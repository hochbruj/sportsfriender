class CreateCities < ActiveRecord::Migration
  def up
    create_table :cities do |t|
      t.string :name
      t.string :full_name
      t.string :country
      t.string :zone
      t.float :lat
      t.float :lng

      t.timestamps
    end
    City.create_translation_table! :name => :string, :full_name => :string
  end
  
  def down
    drop_table :cities
    City.drop_translation_table!
  end
  
end
