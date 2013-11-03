module SprintsHelper
  def get_chart_data(sprints, projects = nil)
    tickets = sprints.map { |s| s.completed_tickets }.flatten
    total = tickets.collect(&:real_hours).compact.inject(:+)
    total_estimate = tickets.collect(&:points).compact.inject(:+)
    total_tickets = tickets.size
    p projects.inspect
    projects = projects || tickets.map { |t| t.project }.uniq
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

  def get_sprint_history
    {
      velocity: Sprint.all.collect(&:total_velocity)
    }
  end
end
