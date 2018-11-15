class PlayersController < ApplicationController

  get "/players/:team_id" do # show players on a given team
    @team = Team.find_by_id(params[:team_id])
    if @team.users.include?(current_user)
      erb :"/teams/show" #has form to delete and edit players
    else
      #error message
      redirect "/teams"
    end
  end

  post "/players/:team_id" do
    #create a new player for a given team.
    #a user can't access a team unless they declare it as a favorite
    @team = Team.find_by_id(params[:team_id])
    if @team.users.include?(current_user)
      @player = @team.players.build(params[:player])
      @player.save
    else
      #error message
    end
    redirect "/players/#{@team.id}"
  end

  patch "/players/:team_id" do  ##edit players on team
    @team = Team.find_by_id(params[:team_id])
    if @team.users.include?(current_user)
      player = @team.players.find_by_name(params[:player][:name])
      player.update(params[:player])
      player.save
    else
      #error message
    end
    redirect "/players/#{@team.id}"
  end

end
