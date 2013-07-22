class Project < ActiveRecord::Base
  has_many :tickets
  has_and_belongs_to_many :users

  validates :url, url: { allow_blank: true, message: "Invalid URL, make sure to include 'http://' at the beginning" }

  attr_accessible :abbreviation, :name, :url, :color, :type

  def self.load_seeds
    Project.create(name: 'Go Track', abbreviation: 'RSC', url: 'http://app.gotrackinc.com', color: '#0000FF', type: '')
    Project.create(name: 'Fast Track Fleet', abbreviation: 'FTF', url: 'http://ftfleet.ftfleet.com', color: '#00FF00', type: '')
    Project.create(name: 'Uplink GPS', abbreviation: 'UGPS', url: '', color: '#FF0000', type: '')
    Project.create(name: 'Virtual Fleet Supervisor', abbreviation: 'VFS', url: 'http://login.virtualfleetsupervisor.com', color: '#FF00FF', type: '')
  end

  def belongs_to_external_project?
    url.present? && url!=''
  end
end
