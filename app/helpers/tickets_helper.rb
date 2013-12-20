module TicketsHelper
  def friendly_user_name user
    if user == current_user
      'Me'
    elsif user
      user.full_name
    end
  end

  def ticket_link_or_name(ticket)
    if ticket.valid_external_url?
      link_to ticket.name, ticket.url, target: '_blank'
    else
      ticket.name
    end
  end

  def estimated_by(ticket)
    estimates = ticket.user_ticket_estimates.map { |ute| ute.user.full_name }
    if estimates.any?
      "Estimated by #{estimates.to_sentence}"
    else
      'No estimates available'
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

  def ticket_class(ticket)
    ticket.high_estimate_diff ? 'alert' : ''
  end

  def estimated_json(ticket)
    ticket.user_ticket_estimates.map { |ute| {name: ute.user.full_name, points: ute.points} }.to_json
  end
end
