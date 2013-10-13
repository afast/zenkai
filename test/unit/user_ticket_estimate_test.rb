require 'test_helper'

class UserTicketEstimateTest < ActiveSupport::TestCase
  test 'after destroy' do
    t = Ticket.new name: 'test'
    t.project= projects(:one)
    t.sprint= sprints(:one)
    t.save!
    t.user_ticket_estimates.create! points: 2, user_id: users(:one).id
    estimate = t.user_ticket_estimates.create! points: 4, user_id: users(:two).id
    assert_equal 3, t.reload.points
    estimate.destroy
    assert_equal 2, t.reload.points
  end
end
