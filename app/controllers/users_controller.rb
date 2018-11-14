class UsersController < ApplicationController

  get "/signup" do
    #user is not logged in
    unless Helper.logged_in(session)
      erb :"/users/signup"
    else
      redirect "/" #check this route later
    end
  end

  post "/signup" do
    #instantiate this user
    user = User.new(params)
    #try to save the user
    if user.save
    #if the user saves,
      session["user_id"] = user.id
      binding.pry
      redirect "/teams"
    else
      #diplsay error message
      redirect "/signup"
    end
  end

  get "/login" do
    unless Helper.logged_in(session)
      erb :"/users/login"
    else
      redirect "/"
  end

  post "/login" do

  end

  get "logout" do

  end

end
