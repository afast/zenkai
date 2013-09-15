class ConvertStartAndEndToDatesForSprints < ActiveRecord::Migration
  def up
    change_column(:sprints, :start, :date)
    change_column(:sprints, :end, :date)
  end

  def down
    change_column(:sprints, :start, :datetime)
    change_column(:sprints, :end, :datetime)
  end
end
