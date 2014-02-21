class RenameEndToSprintEnd < ActiveRecord::Migration
  def change
    rename_column :sprints, :end, :sprint_end
  end
end
