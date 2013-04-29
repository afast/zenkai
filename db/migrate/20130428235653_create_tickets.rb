class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :project_id
      t.string :name
      t.integer :estimated_minutes
      t.integer :real_minutes
      t.integer :points
      t.integer :user_id

      t.timestamps
    end
  end
end
