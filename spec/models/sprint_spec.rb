require 'spec_helper'

describe Sprint do
  let(:sprint1) { FactoryGirl.create(:sprint, start: Time.now - 15.days) }
  let(:sprint2) { Sprint.create(start: sprint1.end + 1.day, end: sprint1.end + 15.days) }
  it 'copies pending tickets over from previous sprint' do
    t = FactoryGirl.create(:ticket, sprint: sprint1)
    Sprint.current!
    t.reload.sprint.should eq(Sprint.last)
    t.sprint.should not_eq(sprint1)
  end
end
