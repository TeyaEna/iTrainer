class AddWorkOutColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :experience, :string
    add_column :users, :exercise_type, :string
    add_column :users, :prefered_time, :string
    add_column :users, :prefered_place, :string
  end
end
