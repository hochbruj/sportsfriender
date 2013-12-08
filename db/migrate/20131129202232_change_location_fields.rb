class ChangeLocationFields < ActiveRecord::Migration
  def change
      add_column :locations, :reference, :string
      add_column :locations, :google_id, :string
      remove_column :locations, :address
      remove_column :locations, :city_id
      remove_column :locations, :user_id
      remove_column :locations, :telephone
      remove_column :locations, :website
      remove_column :locations, :private
    end
end
