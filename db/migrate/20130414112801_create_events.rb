class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :sport_id
      t.integer :city_id
      t.integer :location_id
      t.datetime :start_at
      t.datetime :finish_at
      t.string :mode
      t.string :gender
      t.text :info
      t.integer :skill_from
      t.integer :skill_to
      t.integer :age_from
      t.integer :age_to
      t.integer :max_part
      t.integer :group_id
      t.boolean :private
      t.boolean :cancelled
      t.text :creason
      t.string :emails

      t.timestamps
    end
  end
end
