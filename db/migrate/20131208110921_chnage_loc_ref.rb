class ChnageLocRef < ActiveRecord::Migration
  def up
    change_column :locations, :reference, :text
  end

  def down
    change_column :locations, :reference, :string
  end
end
