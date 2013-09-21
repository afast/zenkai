class ReEstimateAllTickets < ActiveRecord::Migration
  def up
    Ticket.all.each do |ticket|
      ticket.estimate!
    end
  end

  def down
    # Nope...
  end
end
