class TicketsController < ApplicationController
  before_filter :get_projects, only: [:new, :create, :edit, :update, :dashboard]
  # GET /tickets
  # GET /tickets.json
  def index
    @tickets = Ticket
    @tickets = @tickets.where(project_id: params[:project]) if params[:project].present?
    @tickets = @tickets.where(user_id: params[:user]) if params[:user].present?
    @tickets = @tickets.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tickets }
    end
  end

  def report
    scope = Ticket
    scope = scope.where(project_id: params[:project]) if params[:project].present?
    scope = scope.where(user_id: params[:user]) if params[:user].present?
    @from = params[:from].blank? ? (DateTime.now - 1.week) : DateTime.parse(params[:from])
    @sprint_size = params[:sprint_size].blank? ? 1 : params[:sprint_size].to_i
    @sprints = Ticket.report scope, @from, @sprint_size
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
    @ticket = Ticket.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ticket }
    end
  end

  # GET /tickets/new
  # GET /tickets/new.json
  def new
    @ticket = Ticket.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ticket }
    end
  end

  # GET /tickets/1/edit
  def edit
    @ticket = Ticket.find(params[:id])
  end

  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = Ticket.new(params[:ticket])

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to @ticket, notice: 'Ticket was successfully created.' }
        format.json { render json: @ticket, status: :created, location: @ticket }
      else
        format.html { render action: "new" }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tickets/1
  # PUT /tickets/1.json
  def update
    @ticket = Ticket.find(params[:id])

    respond_to do |format|
      if @ticket.update_attributes(params[:ticket])
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy

    if request.xhr?
      render nothing: true
    else
      respond_to do |format|
        format.html { redirect_to tickets_url }
        format.json { head :no_content }
      end
    end
  end

  def dashboard
    @tickets = Ticket.all
    @ticket = Ticket.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tickets }
    end
  end

  def list
    @tickets = Ticket.all
    render partial: 'list'
  end

  private
  def get_projects
    @projects = Project.all
  end
end
