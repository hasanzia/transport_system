class CreateVehicles < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicles do |t|
      t.string :registration_number
      t.integer :type
      t.text :description
      t.references :company, foreign_key: true, index: true

      t.timestamps
    end
  end
end
