class CreateTargetPointsOnSprint < ActiveRecord::Migration
  def change
    add_column :sprints, :target_points, :integer
  end
end
