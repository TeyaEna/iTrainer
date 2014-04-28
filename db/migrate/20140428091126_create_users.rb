class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name 
      t.string :last_name
      t.string :screen_name
      t.integer :age
      t.string :gender
      t.text :about_me
      t.string :exercise_type
      t.integer :location_id
      t.string :experience
      t.timestamps
    end
  end
end
