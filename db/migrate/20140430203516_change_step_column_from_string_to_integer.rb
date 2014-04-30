class ChangeStepColumnFromStringToInteger < ActiveRecord::Migration
  def change
    remove_column :users, :step
    add_column :users, :step, :integer, default: 1
  end
end
