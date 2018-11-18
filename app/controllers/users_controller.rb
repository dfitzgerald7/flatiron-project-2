class UsersController < ApplicationController

  get "/signup" do
    #user is not logged in
    unless logged_in
      erb :"/users/signup"
    else
      flash[:message] = "You are already logged in."
      redirect "/"
    end
  end

  post "/signup" do
    #instantiate this user
    user = User.new(params)
    #try to save the user
    if user.save
    #if the user saves,
      session["user_id"] = user.id
      redirect "/teams"
    else
      flash[:message] = "Invalid Input. Please try again."
      redirect "/signup"
    end
  end

  get "/login" do
    unless logged_in
      erb :"/users/login"
    else
      flash[:message] = "You are already logged in."
      redirect "/"
    end
  end

  post "/login" do
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/teams"
    else
      flash[:message] = "That account does not exist."
      redirect "/login"
    end
  end

  get "/logout" do
    if logged_in
      session.clear
    end
      flash[:message] = "You are not logged in."
      redirect "/"
  end

end
