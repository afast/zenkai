class UserTicketEstimatesController < ApplicationController
  # GET /user_ticket_estimates
  # GET /user_ticket_estimates.json
  def index
    @user_ticket_estimates = if params[:user_id]
                               User.find(params[:user_id]).user_ticket_estimates.includes(:ticket).all
                             else
                               UserTicketEstimate.includes(:ticket).includes(:user).all
                             end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user_ticket_estimates }
    end
  end

  # GET /user_ticket_estimates/1
  # GET /user_ticket_estimates/1.json
  def show
    @user_ticket_estimate = UserTicketEstimate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user_ticket_estimate }
    end
  end

  # GET /user_ticket_estimates/new
  # GET /user_ticket_estimates/new.json
  def new
    @user_ticket_estimate = UserTicketEstimate.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_ticket_estimate }
    end
  end

  # GET /user_ticket_estimates/1/edit
  def edit
    @user_ticket_estimate = UserTicketEstimate.find(params[:id])
  end

  # POST /user_ticket_estimates
  # POST /user_ticket_estimates.json
  def create
    @user_ticket_estimate = UserTicketEstimate.new(params[:user_ticket_estimate])

    respond_to do |format|
      if @user_ticket_estimate.save
        format.html { redirect_to @user_ticket_estimate, notice: 'User ticket estimate was successfully created.' }
        format.json { render json: @user_ticket_estimate, status: :created, location: @user_ticket_estimate }
      else
        format.html { render action: "new" }
        format.json { render json: @user_ticket_estimate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /user_ticket_estimates/1
  # PUT /user_ticket_estimates/1.json
  def update
    @user_ticket_estimate = UserTicketEstimate.find(params[:id])

    respond_to do |format|
      if @user_ticket_estimate.update_attributes(params[:user_ticket_estimate])
        format.html { redirect_to @user_ticket_estimate, notice: 'User ticket estimate was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user_ticket_estimate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_ticket_estimates/1
  # DELETE /user_ticket_estimates/1.json
  def destroy
    @user_ticket_estimate = UserTicketEstimate.find(params[:id])
    ticket = @user_ticket_estimate.ticket
    @user_ticket_estimate.destroy
    current_user.estimate! ticket

    respond_to do |format|
      format.html { redirect_to user_ticket_estimates_url }
      format.json { head :no_content }
    end
  end
end
