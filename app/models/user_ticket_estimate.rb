class UserTicketEstimate < ActiveRecord::Base
  attr_accessible :estimated_hours, :points, :ticket_id, :user_id

  after_save :update_ticket, if: :ticket
  before_destroy :update_ticket

  belongs_to :user
  belongs_to :ticket

  attr_accessible :estimated_hours, :name, :points, :project_id, :real_hours, :user_id
  delegate :name, :project_id, :real_hours, to: :ticket, prefix: false, allow_nil: true
  delegate :full_name, to: :user, prefix: true, allow_nil: true

  def update_ticket
    ticket.estimate
  end
end
