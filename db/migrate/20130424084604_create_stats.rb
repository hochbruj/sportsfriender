class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.integer :user_id
      t.integer :sport_id
      t.decimal :cat1, :precision => 3, :scale => 1
      t.decimal :cat2, :precision => 3, :scale => 1
      t.decimal :cat3, :precision => 3, :scale => 1
      t.decimal :cat4, :precision => 3, :scale => 1
      t.decimal :cat5, :precision => 3, :scale => 1

      t.timestamps
    end
  end
end
