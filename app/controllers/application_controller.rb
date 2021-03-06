require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions #flash messages
    register Sinatra::Flash
  end

  get "/" do
    erb :index
  end

  helpers do
    def current_user
      User.find_by_id(session["user_id"])
    end

    def logged_in
      !!session["user_id"]
    end

  end

  get "/leaderboard" do
    @players = Player.all
    erb :leaderboard
  end


end
