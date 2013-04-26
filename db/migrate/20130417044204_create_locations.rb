class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :address
      t.integer :city_id
      t.integer :sport_id
      t.integer :user_id
      t.string :telephone
      t.string :website
      t.float :lat
      t.float :lng
      t.boolean :private

      t.timestamps
    end
  end
end
