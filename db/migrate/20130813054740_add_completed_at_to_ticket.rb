class AddCompletedAtToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :completed_at, :datetime
  end
end
