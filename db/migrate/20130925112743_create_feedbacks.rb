class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.integer :user_id
      t.integer :sport_id
      t.integer :rated_by
      t.string :comment

      t.timestamps
    end
  end
end
