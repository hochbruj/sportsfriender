class CreatePointers < ActiveRecord::Migration
  def change
    create_table :pointers do |t|
      t.integer :user_id
      t.integer :cat_id

      t.timestamps
    end
  end
end
