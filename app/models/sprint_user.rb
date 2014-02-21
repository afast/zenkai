class SprintUser < ActiveRecord::Base
  belongs_to :sprint
  belongs_to :user
  attr_accessible :code_review, :estimation, :sprint_id, :user_id

  delegate :name, to: :sprint, prefix: true, allow_nil: true

  def user_name
    user.try(:full_name)
  end
end
