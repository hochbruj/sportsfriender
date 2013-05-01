class CreateEventPosts < ActiveRecord::Migration
  def change
    create_table :event_posts do |t|
      t.string :content
      t.integer :event_id
      t.integer :user_id

      t.timestamps
    end
  end
end
