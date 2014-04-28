class AddStepToUser < ActiveRecord::Migration
  def change
    add_column :users, :step, :string, default: "1st step"
  end
end
