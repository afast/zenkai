class Project < ActiveRecord::Base
  attr_accessible :abbreviation, :name

  has_many :tickets

  def short_name
    abbreviation
  end
end
