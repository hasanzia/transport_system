class TripsController < ApplicationController

  before_action :authenticate_user
  before_action :current_company
  before_action :authenticate_admin_user, only: [:create]

  def index
    if params[:starting_at].present? && params[:ending_at].present?
      if params[:user_id].present? && params[:vehicle_id].present?
        user = User.find_by(id: params[:user_id])
        vehicle = Vehicle.find_by(id: params[:vehicle_id])
        if user.present? && vehicle.present?
          trips = Trip.where(user_id: params[:user_id], vehicle_id: params[:vehicle_id])
        else
          render json: { message: "No such User or Vehicle is present at the moment."}, status: 404 and return
        end
      elsif params[:user_id].present?
        user = User.find_by(id: params[:user_id])
        if user.present?
          user_trips = user&.trips
          trips = user_trips
        else
          render json: { message: "No such User is present at the moment."}, status: 404 and return
        end
      elsif params[:vehicle_id].present?
        vehicle = Vehicle.find_by(id: params[:vehicle_id])
        if vehicle.present?
          vehicle_trips = vehicle&.trips
          trips = vehicle_trips
        else
          render json: { message: "No such Vehicle is present at the moment."}, status: 404 and return
        end
      else
        trips = Trip.all
      end

      trips = trips&.where(" (starting_at BETWEEN '#{params[:starting_at]}' AND '#{params[:ending_at]}') OR (ending_at BETWEEN '#{params[:starting_at]}' AND '#{params[:ending_at]}') ")
      if trips.any?
        render json: { trips: trips }, status: 200
      else
        render json: { message: "No such trips are present at the moment."}, status: 404 and return
      end
    else
      render json: { message: "Trip's starting_at and ending_at time is mandatory to this endpoint."}, status: 422 and return
    end
  end

  def create
    if all_trips_created?
      render json: { message: "All trips successfully created." }, status: 201
    else
      render json: { message: "None of the trips created, please check no new trip overlaps with any previous same user or same vehicle trip for the same duration." }, status: 400
    end
  end

  def trips_summary
    if params[:starting_at].present? && params[:ending_at].present?
      if params[:user_id].present?
        user = User.find_by(id: params[:user_id])
        if user.present?
          user_trips = user&.trips&.where(" (starting_at BETWEEN '#{params[:starting_at]}' AND '#{params[:ending_at]}') AND (ending_at BETWEEN '#{params[:starting_at]}' AND '#{params[:ending_at]}') ")
          if user_trips.any?
            payload = {
              user: user,
              trips: user_trips.size,
              distance: user_trips.sum(:distance_travelled)
            }
            render json: { trips_summary: payload }, status: 200
          else
            render json: { message: "No such User's trip is present at the moment."}, status: 404 and return
          end
        else
          render json: { message: "No such User is present at the moment."}, status: 404 and return
        end
      elsif params[:vehicle_id].present?
        vehicle = Vehicle.find_by(id: params[:vehicle_id])
        if vehicle.present?
          vehicle_trips = vehicle&.trips&.where(" (starting_at BETWEEN '#{params[:starting_at]}' AND '#{params[:ending_at]}') AND (ending_at BETWEEN '#{params[:starting_at]}' AND '#{params[:ending_at]}') ")
          if vehicle_trips.any?
            payload = {
              vehicle: vehicle,
              trips: vehicle_trips.size,
              distance: vehicle_trips.sum(:distance_travelled)
            }
            render json: { trips_summary: payload }, status: 200
          else
            render json: { message: "No such Vehicle's trip is present at the moment."}, status: 404 and return
          end
        else
          render json: { message: "No such Vehicle is present at the moment."}, status: 404 and return
        end
      else
        render json: { message: "Trip's user_id or vehicle_id is mandatory to this endpoint." }, status: 422 and return
      end
    else
      render json: { message: "Trip's starting_at and ending_at time is mandatory to this endpoint." }, status: 422 and return
    end
  end

  private

    def trips_params
      params.permit(trips: [:starting_at, :ending_at, :distance_travelled, :user_id, :vehicle_id])
    end

    def all_trips_created?
      begin
        ActiveRecord::Base.transaction do
          trips_params[:trips].each do |trip_params|
            trip = current_company.trips.create!(trip_params)
          end
        end
        true
      rescue => e
        false
      end
    end
end
