require 'spec_helper'

describe TicketsController do
  before do
    sign_in(create(:user))
  end

  describe 'POST ignore_ticket_path' do
    let(:ticket) { create(:ticket) }

    it 'creates a user_ticket_estimate' do
      expect {
        post :ignore, id: ticket.id
      }.to change(UserTicketEstimate, :count).by(1)
    end

    it 'assigns nil points' do
      post :ignore, id: ticket.id
      UserTicketEstimate.last.points.should be_nil
    end

    it 'returns success' do
      post :ignore, id: ticket.id
      response.should be_success
    end
  end
end
