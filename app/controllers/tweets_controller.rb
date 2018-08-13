class TweetsController < ApplicationController

  get '/tweets' do
    @tweets = Tweet.all
    erb :'/tweets/tweets'
  end

  get '/tweets/new' do
    @current_user = current_user
    erb :'/tweets/create_tweet'
  end

  post '/tweets' do
    @tweet = Tweet.new(content: params[:content])
    current_user.tweets << @tweet
    @tweet.save
    redirect "/tweets/#{@tweet.id}"
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    if session[:user_id] == @tweet.user_id
      erb :'/tweets/edit_tweet'
    else
      erb :'/users/error'
    end 
  end

  post '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @tweet.content = params[:content]
    @tweet.save
    redirect "/tweets/#{@tweet.id}"
  end

  post '/tweets/:id/delete' do 
    
  end 

end
