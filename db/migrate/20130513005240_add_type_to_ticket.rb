class AddTypeToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :type, :string
  end
end
