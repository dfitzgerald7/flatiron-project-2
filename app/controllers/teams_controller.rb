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
    if Team.find_by_name(params[:name])
      
    team = Team.create(params)
    team.users << current_user
    redirect "/teams"
  end


  delete "/teams/delete" do
    @team = Team.find_by_name(params[:team_name])
    if @team && @team.users.include?(current_user)
      UserTeam.find_by_team_id(@team.id).delete #How to make sure the right connection is found?
    end
    redirect "/teams"
  end

end
