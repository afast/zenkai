class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  scope :estimated, where(Ticket.arel_table[:estimated_hours].not_eq(nil))
  scope :done, where(Ticket.arel_table[:real_hours].not_eq(nil))
  scope :complete, Ticket.estimated.done
  scope :from_date, -> date_from {
    where('created_at >= ? and created_at <= ?', date_from, DateTime.now) if date_from.present?
  }
  scope :in_range, -> date_from, date_to {
    where('created_at >= ? and created_at <= ?', date_from, date_to)
  }

  attr_accessible :estimated_hours, :name, :points, :project_id, :real_hours, :user_id

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

  def valid_external_url?
    belongs_to_external_project? && project_abbreviation_matches_name?
  end

  def url
    "#{project.url.split('/').join('/')}-#{name.split('-').last}"
  end

  def deviation
    real_hours - estimated_hours
  end

  def percent_error
    if real_hours.present? && estimated_hours.present?
      '%.2f' % (((real_hours - estimated_hours) / estimated_hours)*100)
    else
      0.0
    end
  end

  def self.report(initial_scope, from_date, sprint_weeks)
    from_date ||= DateTime.now.beginning_of_week
    sprint_weeks ||= 1
    tickets = []
    now = DateTime.now
    while from_date < now
      to_date = from_date + sprint_weeks.weeks
      tickets << Sprint.new(initial_scope.complete.in_range from_date, to_date)
      from_date = to_date
    end
    tickets
  end

  private

  def project_abbreviation_matches_name?
    name.split('-').first == project.abbreviation
  end

end
