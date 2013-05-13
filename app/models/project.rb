class Project < ActiveRecord::Base
  has_many :tickets

  validates :url, url: { allow_blank: true, message: "Invalid URL, make sure to include 'http://' at the beginning" }

  attr_accessible :abbreviation, :name, :url, :color, :type

  def belongs_to_external_project?
    url.present?
  end
end
