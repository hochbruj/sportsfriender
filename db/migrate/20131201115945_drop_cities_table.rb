class DropCitiesTable < ActiveRecord::Migration
  def up
    drop_table :cities
    City.drop_translation_table!
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
