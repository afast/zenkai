class ApiController < ActionController::Base
  skip_before_filter :authenticate_user!

  def pending_estimates
    respond_to do |format|
      format.json { render json: Ticket.pending_estimate }
    end
  end

  def create_ticket
    if params[:api_key] != API_TOKEN
      render json: {error: 'Invalid API Token'}, status: :unprocessable_entity && return
    end
    ticket = Ticket.new name: params[:name].upcase
    ticket.project = Project.where(abbreviation: params[:name].gsub(/-.*/, '').upcase).first
    ticket.sprint = Sprint.current!

    if ticket.save
      render json: ticket, status: :created, location: ticket
    else
      render json: ticket.errors, status: :unprocessable_entity
    end
  end
end
