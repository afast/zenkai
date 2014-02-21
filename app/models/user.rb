class User < ActiveRecord::Base
  has_many :tickets
  has_and_belongs_to_many :projects
  has_many :user_ticket_estimates

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :name, :password, :password_confirmation, :remember_me,
    :approved

  def self.load_seeds
    if User.where(email: 'admin@moove-it.com').empty?
      user = User.new(email: 'admin@moove-it.com', password: 'testingzenkai', name: 'MooveIT ZENKAI Admin', approved: true)
      user.admin = true
      user.save!
    end

    if User.where(email: 'gabriel.fagundez@moove-it.com').empty?
      user = User.new(email: 'gabriel.fagundez@moove-it.com', password: 'testingzenkai', name: 'Gabriel Fagundez de los Reyes', approved: true)
      user.save!
    end

    if User.where(email: 'andreas.fast@moove-it.com').empty?
      user = User.new(email: 'andreas.fast@moove-it.com', password: 'testingzenkai', name: 'Andreas Fast', approved: true)
      user.save!
    end

    if User.where(email: 'rodrigo.deleon@moove-it.com').empty?
      user = User.new(email: 'rodrigo.deleon@moove-it.com', password: 'testingzenkai', name: 'Rodrigo De Leon', approved: true)
      user.save!
    end

    if User.where(email: 'matias.nieves@moove-it.com').empty?
      user = User.new(email: 'matias.nieves@moove-it.com', password: 'testingzenkai', name: 'Matias Nieves', approved: true)
      user.save!
    end

    if User.where(email: 'virginia.rodriguez@moove-it.com').empty?
      user = User.new(email: 'virginia.rodriguez@moove-it.com', password: 'testingzenkai', name: 'Virginia Rodriguez', approved: true)
      user.save!
    end
  end

  def full_name
    name || email.gsub(/@.+/, '')
  end

  def estimation(value, array)
    array.min{|a,b|  (value-a).abs <=> (value-b).abs }
  end

  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    if !approved?
      :not_approved
    else
      super # Use whatever other message
    end
  end
end
