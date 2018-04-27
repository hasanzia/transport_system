class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :role
      t.references :company, foreign_key: true, index: true
      t.text :address

      t.timestamps
    end
  end
end
