class RemoveWorkoutPreferenceTable < ActiveRecord::Migration
  def change
    drop_table :workout_preferences
  end
end
