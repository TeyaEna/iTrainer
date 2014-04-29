class WorkoutPreference < ActiveRecord::Base
  validates :exercise_type, :experience,:prefered_times, presence: true

  belongs_to :user
end