class User < ActiveRecord::Base
  has_many :user_teams
  has_many :teams, through: :user_teams
  has_secure_password
  validates :username, :email, presence: true, uniqueness: true
end
