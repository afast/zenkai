class ChangeEstimatedMinutesToEstimatedHours < ActiveRecord::Migration
  def up
    remove_column :tickets, :real_minutes
    add_column :tickets, :real_hours, :float
    remove_column :tickets, :estimated_minutes
    add_column :tickets, :estimated_hours, :float
  end

  def down
    remove_column :tickets, :estimated_hours
    add_column :tickets, :estimated_minutes, :integer
    remove_column :tickets, :real_hours
    add_column :tickets, :real_minutes, :integer
  end
end
