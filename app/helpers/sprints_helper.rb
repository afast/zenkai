module SprintsHelper
  def full_sprint_history
    {
      velocity: Sprint.closed.collect(&:total_velocity)
    }
  end

  def sprint_history_for_project(project)
    {
      velocity: Sprint.closed.map { |s| s.total_velocity('tickets.project_id' => project.id) }
    }
  end

  def full_chart_data(sprints)
    tickets        = sprints.map { |s| s.completed_tickets }.flatten
    total          = tickets.collect(&:real_hours).compact.inject(:+)
    total_estimate = tickets.collect(&:points).compact.inject(:+)
    total_tickets  = tickets.size
    projects       = tickets.map { |t| t.project }.uniq
    {
        hours_per_project: projects.map { |p| [sprints.map { |s| s.total_hours('tickets.project_id' => p.id) }.compact.inject(:+)] },
        projects: projects.map { |p| { label: p.name } }.to_json,
        hour_distribution: [projects.map { |p| [p.name, (sprints.map { |s| s.total_hours('tickets.project_id' => p.id) }.compact.inject(:+) / total) * 100]}],
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
end
