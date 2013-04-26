class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.integer :user_id
      t.integer :event_id
      t.boolean :organizer
      t.boolean :rated

      t.timestamps
    end
  end
end
