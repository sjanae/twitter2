class TweetsController < ApplicationController

  def index
    if params[:q]
      tweets = Tweet.where(" ", "%#{params[:q]}%")
    else
      tweets = Tweet
    end
    tweets = tweets.page(params[:page]).per(params[:size])
    render json: tweets, include: params[:include]
  end

  # GET /tweets/1
  # GET /tweets/1.json
  def show
    tweet = Tweet.find(params[:id])
    render json: tweet, include: params[:include]
  end

  # POST /tweets
  # POST /tweets.json
  def create
    tweet = Tweet.new(tweet_params)
    tweet.user_id = current_user.id
    if tweet.save
      render json: tweet, status: :created
    else
      render json: tweet.errors, status: :unprocessable_entity
    end
  end

  def update
    tweet = Tweet.find(params[:id])
    if current_user.id == tweet.user_id
      tweet.update(tweet_params)
    else
      head :no_content
    end
  end
  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy
    tweet = Tweet.find(params[:id])
    if current_user.id == tweet.user_id
      tweet.destroy
    else
      head :no_content
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:body)
  end
end
