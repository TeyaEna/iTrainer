class AddUserIdToWorkoutPreferences < ActiveRecord::Migration
  def change
    add_column :workout_preferences, :user_id, :integer
  end
end
