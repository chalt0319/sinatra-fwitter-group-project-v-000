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
    erb :'/tweets/show'
  end
end
