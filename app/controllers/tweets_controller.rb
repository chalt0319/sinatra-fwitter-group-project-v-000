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
    result = current_user.tweets.any? do |tweet|
      tweet.id == params[:id].to_i
    end
    if result == true
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      erb :'/users/error'
    end
  end

  get '/tweets/:id/edit' do

  end

  post '/tweets/edit' do

  end 

end
