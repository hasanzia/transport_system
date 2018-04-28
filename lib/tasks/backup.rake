namespace :backup do
  task six_month_old_trips: :environment do
    six_month_old_trips = Trip.where("created_at < ?", 6.months.ago)
    six_month_old_trips.each do |trip|
      begin
        TripArchive.create!(trip.attributes.except("id"))
        trip.destroy!
      rescue => e
        Rails.logger.error(e.message)
      end
    end
  end
end
