module TicketsHelper

  def friendly_user_name user
    if user == current_user
      'Me'
    else
      user.name
    end
  end

  def ticket_link_or_name(ticket)
    if ticket.valid_external_url?
      link_to ticket.name, ticket.url
    else
      ticket.name
    end
  end

end
