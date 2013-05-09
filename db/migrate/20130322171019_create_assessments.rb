class CreateAssessments < ActiveRecord::Migration
  def up
    create_table :assessments do |t|
      t.integer :sport_id
      t.integer :level
      t.text :cat1
      t.text :cat2
      t.text :cat3
      t.text :cat4
      t.text :cat5

      t.timestamps
    end
    Assessment.create_translation_table! :cat1 => :text, :cat2 => :text, :cat3 => :text, :cat4 => :text, :cat5 => :text
  end

  def down
       drop_table :assessments
       Assessment.drop_translation_table!
  end

end
