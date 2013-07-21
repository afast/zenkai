module ProjectsHelper

  def project_url_link(project)
    link_to project.url, project.url if project.belongs_to_external_project?
  end

end
