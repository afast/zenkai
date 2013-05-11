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

  def sprint_info initial_from, sprint_size, sprint_number
    if initial_from.blank?
      initial_from = DateTime.now - 1.week
    else
      initial_from = Date.parse initial_from
    end
    if sprint_size.blank?
      sprint_size = 1
    else
      sprint_size = sprint_size.to_i
    end
    from = initial_from + (sprint_size*(sprint_number - 1)).weeks
    to = (initial_from + (sprint_size*sprint_number).weeks) - 1.day
    "Sprint #{from.strftime('%m/%d')} - #{to.strftime('%m/%d')}"
  end
end
