class AddMinEstimatesToProject < ActiveRecord::Migration
  def change
    add_column :projects, :min_estimates, :integer
  end
end
