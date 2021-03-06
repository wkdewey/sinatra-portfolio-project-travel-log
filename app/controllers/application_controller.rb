require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
    register Sinatra::Flash
  end

  get "/" do
    if logged_in?
      redirect "/users"
    else
      erb :welcome
    end
  end

  get "/signup" do
    if logged_in?
      already_logged_in
    else
      erb :signup
    end
  end

  get "/logout" do
    erb :logout
  end

  get '/login' do
    if logged_in?
      already_logged_in
    else
      erb :login
    end
  end

  post '/signup' do
    user = User.new(:name => params[:name], :hometown => params[:hometown], :password => params[:password])
    if user.save
      start_session(user)
    else
      flash[:error] = "You must fill out all fields and have a unique username. Please try again"
      redirect "/signup"
    end
  end

  post '/login' do
    user = User.find_by(:name => params[:name])
    if user && user.authenticate(params[:password])
      start_session(user)
    else
      flash[:error] = "User name and/or password is invalid"
      redirect "/login"
    end
  end

  post '/logout' do
    session.clear
    redirect "/"
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      @current_user ||= User.find_by(:id => session[:user_id])
    end

    def login_error
      flash[:error] = "You must log in to see that page"
      redirect "/login"
    end

    def already_logged_in
      flash[:error] = "You are already logged in"
      redirect "/users"
    end

    def start_session(user)
      session[:user_id] = user.id
      redirect "/users"
    end
  end

end
