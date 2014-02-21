class Sprint < ActiveRecord::Base
  DEFAULT_DURATION = 2.weeks - 1.day

  has_many :tickets
  has_many :sprint_users

  scope :sorted, order('start DESC')
  validates_presence_of :start, :end
  attr_accessible :end, :start

  class << self
    # Returns the current sprint if it's still in progress.
    # If the last sprint has already finished, creates a new one of DEFAULT_DURATION days and returns it.
    def current!
      previous = Sprint.last_one
      return previous if previous.try(:in_progress?)
      Sprint.create_from_previous(previous)
    end

    def last_one
      Sprint.order('end DESC').first
    end

    def create_from_previous(previous)
      start_date = previous ? previous.end.tomorrow : Date.today
      end_date = start_date + DEFAULT_DURATION
      sprint = Sprint.create!(start: start_date, end: end_date)
      if previous
        logger.info "Moving #{previous.tickets.pending.count} peding tickets (out of #{previous.tickets.count}) to new sprint"
        previous.tickets.pending.update_all(sprint_id: sprint.id)
      end
      sprint
    end

    def closed
      where('id != ?', current!.id)
    end
  end

  def date_span
    "#{start.to_date} - #{self.end.to_date}"
  end

  def total_hours(conditions = {})
    completed_tickets.where(conditions).collect(&:real_hours).compact.inject(:+) || 0
  end

  def total_estimate(conditions = {})
    completed_tickets.where(conditions).collect(&:points).compact.inject(:+) || 0
  end

  def total_velocity(conditions = {})
    hours = total_hours(conditions)
    return 0 if hours.zero?
    total_estimate(conditions) / hours.to_f
  end

  def name
    "#{start.strftime('%m/%d/%y')} - #{self.end.strftime('%m/%d/%y')}"
  end

  def completed_tickets
    tickets.complete
  end

  def code_review_time
    sprint_users.sum :code_review
  end

  def estimate_time
    sprint_users.sum :estimation
  end

  private

  def in_progress?
    Date.today.between?(self.start, self.end)
  end
end
