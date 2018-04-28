class CreateTripArchives < ActiveRecord::Migration[5.2]
  def change
    create_table :trip_archives do |t|
      t.datetime :starting_at
      t.datetime :ending_at
      t.float :distance_travelled
      t.integer :vehicle_id, limit: 8, null: false
      t.integer :user_id, limit: 8,  null: false
      t.integer :company_id, limit: 8, null: false
      t.text :description

      t.timestamps
    end
  end
end
