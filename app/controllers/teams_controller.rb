class TeamsController < ApplicationController

  get "/teams" do
    if logged_in
      @user = current_user
      @teams = @user.teams
      erb :"/teams/index"
    else

    end
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

  delete "/teams/:id/delete" do

  end 

end
