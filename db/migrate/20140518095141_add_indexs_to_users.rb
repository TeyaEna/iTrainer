class AddIndexsToUsers < ActiveRecord::Migration
  def change
    add_index(:users, :address, { name: 'users_address_index'})
    add_index(:users, :age, { name: 'users_age_index'})
    add_index(:users, :experience, { name: 'users_experience_index'})
    add_index(:users, :exercise_type, { name: "users_exercise_type"})
    add_index(:users, :gender, { name: "users_gender_index"})
  end
end
