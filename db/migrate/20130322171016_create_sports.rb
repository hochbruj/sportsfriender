class CreateSports < ActiveRecord::Migration
  def up
    create_table :sports do |t|
      t.string :name
      t.string :cat1
      t.string :cat2
      t.string :cat3
      t.string :cat4
      t.string :cat5

      t.timestamps
    end
    Sport.create_translation_table! :name => :string, :cat1 => :string, :cat2 => :string, :cat3 => :string, :cat4 => :string, :cat5 => :string
  end
  
  def down
      drop_table :sports
      Sport.drop_translation_table!
  end
end
