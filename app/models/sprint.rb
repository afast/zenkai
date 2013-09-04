class Sprint < ActiveRecord::Base
  attr_accessible :end, :start
  has_many :tickets

  def date_span
    "#{start.to_date} - #{self.end.to_date}"
  end

  def total_hours(conditions = {})
    tickets.where(conditions).complete.collect(&:real_hours).compact.inject(:+)
  end

  def total_estimate(conditions = {})
    tickets.where(conditions).complete.collect(&:points).compact.inject(:+)
  end

  def total_velocity(conditions = {})
    total_estimate(conditions) / total_hours(conditions).to_f
  end

  def name
    "#{start.strftime('%m/%d/%y')} - #{self.end.strftime('%m/%d/%y')}"
  end
end
