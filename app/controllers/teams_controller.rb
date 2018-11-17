class TeamsController < ApplicationController

  get "/teams" do
    if logged_in
      @user = current_user
      @teams = @user.teams
      erb :"/teams/index"
    else
      flash[:message] = "You are not logged in."
      redirect "/"
    end
  end

  get "/teams/new" do
    if logged_in
      @teams = Team.team_names
      erb :"/teams/new"
    else
      flash[:message] = "You are not logged in."
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
      connection = UserTeam.find_by_team_id_and_user_id(@team.id,current_user.id)
      connection.delete
    end
    redirect "/teams"
  end

end
