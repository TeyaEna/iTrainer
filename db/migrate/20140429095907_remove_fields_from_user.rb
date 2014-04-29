class RemoveFieldsFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :experience
    remove_column :users, :exercise_type
  end
end
