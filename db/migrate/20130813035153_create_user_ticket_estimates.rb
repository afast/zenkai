class CreateUserTicketEstimates < ActiveRecord::Migration
  def change
    create_table :user_ticket_estimates do |t|
      t.integer :user_id
      t.integer :ticket_id
      t.integer :points
      t.integer :estimated_hours

      t.timestamps
    end
  end
end
