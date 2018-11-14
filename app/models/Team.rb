class Team < ActiveRecord::Base
  has_many :users, :players
end
