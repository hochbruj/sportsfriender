class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :provider
      t.string :uid
      t.string :gender
      t.integer :city_id
      t.integer :sport_id
      t.text :comment
      t.date :dob
      t.string :image
      t.boolean :admin

      t.timestamps
    end
  end
end
