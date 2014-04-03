module SprintsHelper
  def full_sprint_history
    {
      velocity: Sprint.closed.collect(&:total_velocity)
    }
  end

  def full_hour_history
    {
      hour: Sprint.closed.collect(&:total_hours)
    }
  end

  def sprint_history_for_project(project)
    {
      velocity: Sprint.closed.map { |s| s.total_velocity('tickets.project_id' => project.id) }
    }
  end

  def sprint_hour_history_for_project(project)
    {
      hour: Sprint.closed.map { |s| s.total_hours('tickets.project_id' => project.id) }
    }
  end

  def full_chart_data(sprints)
    tickets        = sprints.map { |s| s.completed_tickets }.flatten
    total          = tickets.collect(&:real_hours).compact.inject(:+)
    total_estimate = tickets.collect(&:points).compact.inject(:+)
    total_tickets  = tickets.size
    projects       = tickets.map { |t| t.project }.uniq
    {
        hours_per_project: projects.map { |p| [sprints.map { |s| s.total_hours('tickets.project_id' => p.id) }.compact.inject(:+)] } + [[code_review_time(sprints)], [estimate_time(sprints)]],
        projects: (projects.map { |p| { label: p.name } } + [{label: 'Code Review'}, {label: 'Estimating'}]).to_json,
        hour_distribution: [projects.map { |p| [p.name, (sprints.map { |s| s.total_hours('tickets.project_id' => p.id) }.compact.inject(:+) / total) * 100]} + [["Code Review", code_review_time(sprints)], ["Estimating", estimate_time(sprints)]]],
        points_per_project: projects.map { |p| [sprints.map { |s| s.total_estimate('tickets.project_id' => p.id)}.compact.inject(:+)] },
        points_distribution: [projects.map { |p| [p.name, (sprints.map { |s| s.total_estimate('tickets.project_id' => p.id) }.compact.inject(:+) / total_estimate.to_f) * 100]}],
        velocity_per_project: projects.map { |p| sprints.map { |s| s.total_velocity('tickets.project_id' => p.id) } },
        tickets_per_project: [projects.map { |p| [p.name, (sprints.map { |s| s.tickets.complete.where(project_id: p.id).count }.inject(:+) / total_tickets.to_f) * 100] }]
    }
  end

  def chart_data_for_project(sprints, project)
    {
        hours_per_project: [[sprints.map { |s| s.total_hours('tickets.project_id' => project.id) }.compact.inject(:+)]],
        projects: [{ label: project.name }.to_json],
        points_per_project: [[sprints.map { |s| s.total_estimate('tickets.project_id' => project.id)}.compact.inject(:+)]],
        velocity_per_project: [sprints.map { |s| s.total_velocity('tickets.project_id' => project.id) }],
    }
  end

  def code_review_time(sprints)
    @code_review_time ||= SprintUser.where(sprint_id: sprints).sum(:code_review)
  end

  def estimate_time(sprints)
    @estimate_time ||= SprintUser.where(sprint_id: sprints).sum(:estimation)
  end
end
