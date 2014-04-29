class RenameExperienceAndPrefredTimescolumn < ActiveRecord::Migration
  def change
    rename_column :workout_preferences, :prefered_times, :prefered_time
  end
end
