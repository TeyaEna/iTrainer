class WorkoutPreference < ActiveRecord::Base
  validates :exercise_type, :experience,:prefered_time, presence: true

  belongs_to :user
end