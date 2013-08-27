class Sprint < ActiveRecord::Base
  attr_accessible :end, :start
  has_many :tickets

  def date_span
    "#{start.to_date} - #{self.end.to_date}"
  end

  def total_hours
    @total_hours ||= tickets.collect(&:real_hours).compact.inject(:+)
  end

  def total_estimate
    @total_estimate ||= tickets.collect(&:points).compact.inject(:+)
  end

  def total_velocity
    @total_velocity ||= total_estimate / total_hours.to_f
  end
end
