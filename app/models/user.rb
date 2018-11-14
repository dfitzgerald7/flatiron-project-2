class User < ActiveRecord::Base
  has_many :teams
  has_secure_password
  validates :username, :email, presence :true
end
