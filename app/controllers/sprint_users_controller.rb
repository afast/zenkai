class SprintUsersController < ApplicationController
  def new
    @sprint_user = SprintUser.new user_id: current_user.id, sprint_id: Sprint.current!.id
    render layout: false if request.xhr?
  end

  def create
    sprint_user = SprintUser.new params[:sprint_user]
    if sprint_user.save
      render json: {status: 'success'}
    else
      render json: {status: 'error', message: sprint_user.errors.full_messages}
    end
  end

  def index
    @sprint  = params[:sprint].presence || Sprint.current!
    @sprint_users = SprintUser.where(sprint_id: @sprint)
    @sprint_users = @sprint_users.where(user_id: params[:user]) if params[:user].present?
  end

  def destroy
    @sprint_user = SprintUser.find(params[:id])
    @sprint_user.destroy

    if request.xhr?
      render nothing: true
    else
      respond_to do |format|
        format.html { redirect_to sprint_users_url }
        format.json { head :no_content }
      end
    end
  end
end
