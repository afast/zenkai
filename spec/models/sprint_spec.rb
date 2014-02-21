require 'spec_helper'

describe Sprint do
  it 'copies pending tickets over from previous sprint' do
    Sprint.delete_all
    sprint1 = Sprint.create(start: Time.now - 15.days, end: Time.now - 1.day)
    t = Ticket.new(name: 'name', sprint: sprint1)
    t.project = FactoryGirl.create :project
    t.save
    Sprint.current!
    t.reload.sprint.should eq(Sprint.last_one)
    t.sprint.should_not eq(sprint1)
  end
end
