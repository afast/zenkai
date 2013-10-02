class AddApprovedToUser < ActiveRecord::Migration
  def change
    add_column :users, :approved, :boolean
    add_column :users, :admin, :boolean
  end
end
