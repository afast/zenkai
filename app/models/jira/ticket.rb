class Jira::Ticket < Ticket

  class << self

    # Rails relies on this method for naming some keywords in the view helpers like form_for. Needed to infer the correct route.
    def model_name
      Ticket.model_name
    end

  end

  def valid_external_url?
    super && project_abbreviation_matches_name?
  end

  private

  def project_abbreviation_matches_name?
    name.split('-').first == project.abbreviation
  end

end