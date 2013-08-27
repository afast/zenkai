class AddSprintToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :sprint_id, :integer
  end
end
