class CreateWorkoutPreferences < ActiveRecord::Migration
  def change
    create_table :workout_preferences do |t|
      t.string :experience
      t.string :exercise_type
      t.string :prefered_times
      t.string :prefered_place
    end
  end
end
