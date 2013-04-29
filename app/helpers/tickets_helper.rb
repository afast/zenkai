module TicketsHelper
  def friendly_user_name user
    if user == current_user
      'Me'
    else
      user.name
    end
  end
end
