class TeamsController < ApplicationController

  get "/teams" do
    if logged_in
      @user = current_user
      @teams = @user.teams
      erb :"/teams/index"
    else

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
    team = Team.create(params)
    team.users << current_user
    redirect "/teams"
  end

  get "/teams/:id" do
    @team = Team.find_by_id(params[:id])
    if @team.users.include?(current_user)
      erb :"/teams/show"
    else
      #error message
      redirect "/teams"
    end
  end

  patch "/teams/:id" do  ##edit players on team
    @team = Team.find_by_id(params[:id])
    if @team
      
    else

    end
  end

  post "/teams/:id/player" do
    @team = Team.find_by_id(params[:id])
    if @team.users.include?(current_user)
      @player = @team.players.build(name: params[:player])
      @player.save
    else
      #error message
    end
    redirect "/teams/#{@team.id}"
  end

  delete "/teams/delete" do
    @team = Team.find_by_name(params[:team_name])
    if @team && @team.users.include?(current_user)
      UserTeam.find_by_team_id(@team.id).delete #How to make sure the right connection is found?
    end
    redirect "/teams"
  end

end
