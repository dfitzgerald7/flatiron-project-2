class TeamsController < ApplicationController

  get "/teams" do
    if logged_in
      @user = current_user
      @teams = @user.teams
      erb :"/teams/index"
    else
      redirect "/"
    end
  end

  get "/teams/new" do
    if logged_in
      erb :"/teams/new"
    else
      redirect "/"
    end
  end

  post "/teams/new" do
    #if team already exists, add user to arr of teams
    if t = Team.find_by_name(params[:name])
      team = t
    else
      team = Team.create(params)
    end
    team.users << current_user
    redirect "/teams"
  end


  delete "/teams/delete" do
    @team = Team.find_by_name(params[:team_name])
    if @team && @team.users.include?(current_user)
      binding.pry
      connection = UserTeam.find_by_team_id_and_user_id(@team.id,current_user.id) #How to make sure the right connection is found?
      connection.delete
    end
    redirect "/teams"
  end

end
