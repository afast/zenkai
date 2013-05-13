class Sprint
  attr_reader :total_deviation, :total_hours, :total_estimate, :total_error, :tickets

  def initialize(tickets)
    tickets = [] unless tickets.present?
    @tickets = tickets
    @total_hours = tickets.collect(&:real_hours).inject(:+) || 0
    @total_estimate = tickets.collect(&:estimated_hours).inject(:+) || 1
    @total_deviation = @total_hours - @total_estimate
    @total_error = (@total_deviation / @total_estimate) * 100
  end

  def total_error_to_s
    '%.2f' % @total_error
  end
end
