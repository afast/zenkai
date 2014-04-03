class Ticket < ActiveRecord::Base
  VALID_ESTIMATES = [1,2,3,5,8]
  belongs_to :project
  belongs_to :user
  belongs_to :sprint
  has_many :user_ticket_estimates

  before_save :calculate_completed, if: :real_hours_changed?
  scope :estimated, where(Ticket.arel_table[:points].not_eq(nil))
  scope :pending_estimate, where(points: nil)
  scope :pending, where(real_hours: nil)
  scope :done, where(Ticket.arel_table[:real_hours].not_eq(nil))
  scope :by_created_at_desc, order('created_at DESC')
  scope :complete, Ticket.estimated.done
  scope :from_date, -> date_from {
    where('created_at >= ? and created_at <= ?', date_from, DateTime.now) if date_from.present?
  }
  scope :in_range, -> date_from, date_to {
    where('created_at >= ? and created_at <= ?', date_from, date_to)
  }
  scope :completed_in_range, -> date_from, date_to {
    where('completed_at >= ? and completed_at <= ?', date_from, date_to)
  }
  scope :for_sprint, -> sprint {
    where(sprint_id: sprint)
  }
  scope :for_project, -> project {
    where(project_id: project)
  }
  scope :for_user, -> user {
    where(user_id: user)
  }
  scope :search_name, -> name {
    where(Ticket.arel_table[:name].matches("%#{name}%"))
  }

  validates_presence_of :name, :project, :sprint
  validates_uniqueness_of :name

  attr_accessible :estimated_hours, :name, :points, :project_id, :real_hours, :user_id, :sprint_id, :sprint

  after_initialize :set_type_from_project

  with_options allow_nil: true do |ticket|
    with_options prefix: false do |ticket|
      ticket.delegate :belongs_to_external_project?, to: :project
    end
    with_options prefix: true do |ticket|
      ticket.delegate :name, to: :project
      ticket.delegate :color, to: :project
      ticket.delegate :name, to: :user
    end
  end

  class << self
    def report(initial_scope, from_date, sprint_weeks)
      from_date ||= DateTime.now.beginning_of_week
      sprint_weeks ||= 1
      tickets = []
      now = DateTime.now
      while from_date < now
        to_date = from_date + sprint_weeks.weeks
        tickets << Sprint.new(initial_scope.complete.completed_in_range from_date, to_date)
        from_date = to_date
      end
      tickets
    end
  end

  def estimate!
    if user_ticket_estimates.count >= project.min_estimates.to_i
      estimates = user_ticket_estimates.collect(&:points)
      avg = estimates.compact.sum / estimates.size.to_f
      if avg <= VALID_ESTIMATES[0]
        self.points = VALID_ESTIMATES[0]
      elsif avg >= VALID_ESTIMATES.last
        self.points = VALID_ESTIMATES.last
      else
        VALID_ESTIMATES.each_with_index do |estimate, i|
          if avg >= estimate && avg <= VALID_ESTIMATES[i+1]
            if avg >= estimate + (VALID_ESTIMATES[i+1] - estimate)/2
              self.points = VALID_ESTIMATES[i+1]
            else
              self.points = estimate
            end
            break
          end
        end
      end
    else
      self.points = nil
    end
    save
  end

  def valid_external_url?
    belongs_to_external_project?
  end

  def url
    "#{project.url.split('/').join('/')}-#{name.split('-').last}".split(' ').first
  end

  def deviation
    (real_hours || 0) - (estimated_hours || 0)
  end

  def percent_error
    if real_hours.present? && estimated_hours.present?
      '%.2f' % (((real_hours - estimated_hours) / estimated_hours)*100)
    else
      0.0
    end
  end

  def velocity
    points / real_hours if real_hours && points && real_hours > 0
  end

  def high_estimate_diff
    points = user_ticket_estimates.collect(&:points)
    return false unless points.size > 1
    if points.include?(1)
      iterate_estimates(points, [[1,3], [1,5], [1,8]])
    elsif points.include?(8)
      iterate_estimates(points, [[2,8], [3, 8], [5,8]])
    elsif points.include?(2)
      [2,5] & points == [2,5]
    end
  end

  private
  def iterate_estimates(points, cases)
    dangerous = false
    cases.each do |danger|
      dangerous ||= (points & danger == danger)
      break if dangerous
    end
    return dangerous
  end

  def calculate_completed
    if real_hours
      self.completed_at = DateTime.now
    else
      self.completed_at = nil
    end
  end

  def set_type_from_project
    if new_record?
      split_namespace = project.class.to_s.split('::')
      split_namespace.pop
      split_namespace << self.class.to_s unless split_namespace.blank?
      self.type = split_namespace.join('::')
    end
  end

end
