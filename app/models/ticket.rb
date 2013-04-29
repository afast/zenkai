class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  attr_accessible :estimated_minutes, :name, :points, :project_id, :real_minutes, :user_id
end
