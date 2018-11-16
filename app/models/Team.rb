class TeamNameValidator < ActiveModel::Validator
  TEAM_ARR = ["Atlanta Hawks", "Boston Celtics" ,"Brooklyn Nets","Charlotte Bobcats", "Chicago Bulls", "Cleveland Cavaliers", "Dallas Mavericks", "Denver Nuggets", "Detroit Pistons", "Golden State Warriors", "Houston Rockets", "Indiana Pacers","LA Clippers", "LA Lakers", "Memphis Grizzlies", "Miami Heat", "Milwaukee Bucks", "Minnesota Timberwolves", "New Orleans Hornets", "New York Knicks", "Oklahoma City Thunder", "Orlando Magic", "Philadelphia Sixers", "Phoenix Suns",
"Portland Trail Blazers", "Sacramento Kings", "San Antonio Spurs", "Toronto Raptors", "Utah Jazz", "Washington Wizards"]

  def validate(record)
    unless TEAM_ARR.include?(record.name)
      record.errors[:base] << "Not an NBA team."
    end
  end

end

class Team < ActiveRecord::Base
  has_many :user_teams
  has_many :users, through: :user_teams
  has_many :players
  validates :name, presence: true, uniqueness: true
  validates_with TeamNameValidator
end
