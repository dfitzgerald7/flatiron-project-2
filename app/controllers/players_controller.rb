class PlayersController < ApplicationController

  get "/players/:team_id" do # show players on a given team
    @team = Team.find_by_id(params[:id])
    if @team.users.include?(current_user)
      erb :"/teams/show"
    else
      #error message
      redirect "/teams"
    end
  end

  post "players/:team_id" do
    @team = Team.find_by_id(params[:id])
    if @team.users.include?(current_user)
      @player = @team.players.build(params[:player])
      @player.save
    else
      #error message
    end
    redirect "/teams/#{@team.id}"
  end

  patch "/teams/:id" do  ##edit players on team
    @team = Team.find_by_id(params[:id])
    if @team

    else

    end
  end

end
