class ChangeUserFields < ActiveRecord::Migration
  def change
      add_column :users, :city_reference, :string
      add_column :users, :country_code, :string
      add_column :users, :lat, :float
      add_column :users, :lng, :float
      remove_column :users, :city_id
    end
end
