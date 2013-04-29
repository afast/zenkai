class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  attr_accessible :estimated_hours, :name, :points, :project_id, :real_hours, :user_id

  delegate :name, to: :project, prefix: true, allow_nil: true
  delegate :name, to: :user, prefix: true, allow_nil: true
end
