require 'rack-flash'

class UsersController < ApplicationController

  use Rack::Flash

  get '/login' do
    if logged_in? 
      redirect "/show/#{current_user.id}"
    erb :'/users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:username], password: params[:password])
    if @user
      session[:user_id] = @user.id
      redirect "/show/#{@user.id}"
    else
      flash[:message] = "Sorry, username and password do not match."
      redirect "/login"
    end
  end

  get '/signup' do
    erb :'/users/create_user'
  end

  post '/signup' do
    @user = User.new(username: params[:username], password: params[:password], email: params[:email])
    if @user.username != "" && @user.password != "" && @user.email != ""
      @user.save
      redirect "/login"
    else
      erb :'/users/error'
    end
  end

  get '/show/:id' do
    if logged_in? && current_user.id == params[:id].to_i
      @current_user = current_user
      erb :'/users/show'
    else
      redirect "/error"
    end
  end

  get '/error' do
    erb :'/users/error'
  end

  get '/logout' do
    session.clear
    redirect "/"
  end

end
