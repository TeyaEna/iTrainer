class AddIndexToUsersForLatAndLong < ActiveRecord::Migration
  def change
    add_index(:users, :latitude, {name: 'users_latitude_index'})
    add_index(:users, :longitude, {name: 'users_longitude_index'} )
  end
end
