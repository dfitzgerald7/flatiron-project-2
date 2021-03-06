class PlayersController < ApplicationController

  get "/players/:team_id" do # show players on a given team
    @team = Team.find_by_id(params[:team_id])
    if @team && @team.users.include?(current_user)
      erb :"/teams/show" #has form to delete and edit players
    else
      flash[:message] = "You cannot view this team."
      redirect "/teams"
    end
  end

  post "/players/:team_id" do
    #create a new player for a given team.
    #a user can't access a team unless they declare it as a favorite
    @team = Team.find_by_id(params[:team_id])
    if @team.users.include?(current_user)
      @player = @team.players.build(name: params[:player][:name].strip, votes: 1, creator_user: current_user.id)
      @player.save
    else
      flash[:message] = "You cannot see a team you have not declared as a favorite."
    end
    redirect "/players/#{@team.id}"
  end

  patch "/players/:team_id" do  ##Vote on a player
    @team = Team.find_by_id(params[:team_id])
    player = @team.players.find_by_name(params[:player][:name].strip)
    if @team.users.include?(current_user) && player #&& (Time.now - player.updated_at) > 86400
      player.update(votes: player.votes+=1)
      player.save
    else
      flash[:message] = "You cannot vote for that player."
    end
    redirect "/players/#{@team.id}"
  end

  delete "/players/delete" do
    player = Player.find_by_name(params[:player][:name].strip)
    if player && current_user.teams.include?(player.team) && player.creator_user == current_user.id
      player.destroy
      redirect "/players/#{player.team.id}"
    else
      flash[:message] = "You cannot delete a player you did not create."
    end
    redirect "/teams"
  end


end
