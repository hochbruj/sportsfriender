class AddCityIdTimezone < ActiveRecord::Migration
  def change
      add_column :users, :city_id, :string
      add_column :locations, :timezone, :string
  end
end
