class User < ActiveRecord::Base
  has_many :tickets
  has_and_belongs_to_many :projects

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :email, :name

  def self.load_seeds
    if User.where(email: 'admin@moove-it.com').empty?
      user = User.new(email: 'admin@moove-it.com', password: 'testingiepc', name: 'MooveIT IEPC Admin')
      user.save!
    end

    if User.where(email: 'gabriel.fagundez@moove-it.com').empty?
      user = User.new(email: 'gabriel.fagundez@moove-it.com', password: 'testingiepc', name: 'Gabriel Fagundez de los Reyes')
      user.save!
    end

    if User.where(email: 'andreas.fast@moove-it.com').empty?
      user = User.new(email: 'andreas.fast@moove-it.com', password: 'testingiepc', name: 'Andreas Fast')
      user.save!
    end

    if User.where(email: 'santiago.piria@moove-it.com').empty?
      user = User.new(email: 'santiago.piria@moove-it.com', password: 'testingiepc', name: 'Santiago Piria')
      user.save!
    end

    if User.where(email: 'matias.nieves@moove-it.com').empty?
      user = User.new(email: 'matias.nieves@moove-it.com', password: 'testingiepc', name: 'Matias Nieves')
      user.save!
    end

    if User.where(email: 'virginia.rodriguez@moove-it.com').empty?
      user = User.new(email: 'virginia.rodriguez@moove-it.com', password: 'testingiepc', name: 'Virginia Rodriguez')
      user.save!
    end
  end

  def full_name
    name || email
  end
end
