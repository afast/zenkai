class ApiController < ActionController::Base

  def pending_estimates
    respond_to do |format|
      format.json { render json: Ticket.pending_estimate }
    end
  end
end
