class Player < ActiveRecord::Base
  belongs_to :team
  validates :name, :position, presence: true
end
