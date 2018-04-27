class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.datetime :starting_at
      t.datetime :ending_at
      t.float :distance_travelled
      t.references :company, foreign_key: true, index: true
      t.references :user, foreign_key: true, index: true
      t.references :vehicle, foreign_key: true, index: true

      t.timestamps
    end
  end
end
