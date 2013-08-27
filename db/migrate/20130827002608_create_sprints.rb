class CreateSprints < ActiveRecord::Migration
  def change
    create_table :sprints do |t|
      t.datetime :start
      t.datetime :end

      t.timestamps
    end
  end
end
