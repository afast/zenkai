class Basecamp::Project < Project

  class << self

    # Rails relies on this method for naming some keywords in the view helpers like form_for. Needed to infer the correct route.
    def model_name
      Project.model_name
    end

  end

  def short_name
    abbreviation
  end

end
