class Project < ActiveRecord::Base
  has_many :tickets

  validates :url, url: { allow_nil: true, message: "Invalid URL, make sure to include 'http://' at the beginning" }

  attr_accessible :abbreviation, :name, :url

  def short_name
    abbreviation
  end

  def belongs_to_external_project?
    url
  end
end
