class RemoveStepFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :step
  end
end
