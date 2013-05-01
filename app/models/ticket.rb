class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  attr_accessible :estimated_hours, :name, :points, :project_id, :real_hours, :user_id

  with_options allow_nil: true do |ticket|
    with_options prefix: false do |ticket|
      ticket.delegate :belongs_to_external_project?, to: :project
    end
    with_options prefix: true do |ticket|
      ticket.delegate :name, to: :project
      ticket.delegate :name, to: :user
    end
  end

  def valid_external_url?
    belongs_to_external_project? && project_abbreviation_matches_name?
  end

  def url
    "#{project.url.split('/').join('/')}-#{name.split('-').last}"
  end

  private

  def project_abbreviation_matches_name?
    name.split('-').first == project.abbreviation
  end

end
