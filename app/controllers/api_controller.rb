class ApiController < ActionController::Base
  skip_before_filter :authenticate_user!

  def pending_estimates
    respond_to do |format|
      format.json { render json: Ticket.pending_estimate }
    end
  end
end
