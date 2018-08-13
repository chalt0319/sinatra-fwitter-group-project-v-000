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
    current_user.tweets.each do |tweet|
      if tweet.id == params[:id].to_i
        @tweet = Tweet.find(params[:id])
        erb :'/tweets/show_tweet'
      else
        erb :'/users/error'
      end
    end 
  end
  
end
