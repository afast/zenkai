class CreateSprintUsers < ActiveRecord::Migration
  def change
    create_table :sprint_users do |t|
      t.integer :user_id
      t.integer :sprint_id
      t.float :code_review
      t.float :estimation

      t.timestamps
    end
  end
end
