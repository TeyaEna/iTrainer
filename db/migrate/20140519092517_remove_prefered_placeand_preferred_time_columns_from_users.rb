class RemovePreferedPlaceandPreferredTimeColumnsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :prefered_time
    remove_column :users, :prefered_place
  end
end
