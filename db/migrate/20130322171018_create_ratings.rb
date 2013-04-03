class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :user_id
      t.integer :rated_by
      t.integer :sport_id
      t.integer :event_id
      t.integer :cat1
      t.integer :cat2
      t.integer :cat3
      t.integer :cat4
      t.integer :cat5
      t.integer :dif1
      t.integer :dif2
      t.integer :dif3
      t.integer :dif4
      t.integer :dif5
      

      t.timestamps
    end
  end
end