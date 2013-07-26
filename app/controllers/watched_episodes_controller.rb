class WatchedEpisodesController < ApplicationController

  respond_to :json
  skip_before_filter :verify_authenticity_token
  def index
    render json: WatchedEpisode.where(user_id: params[:user_id])
  end

  def show
    render json: WatchedEpisode.where(user_id: params[:user_id])
  end

  def create
    if WatchedEpisode.create(episode_id: params[:episode_id], user_id: params[:user_id]).save
      render json: {}, status: 200
    else
      render json: {}, status: 422
    end
  end

  def update
    watched_episode = WatchedEpisode.find(params[:episode_id])
    watched_episode.update_attributes(params[:episode_ids])
    render json: show
  end

  def destroy
    #@show = WatchedEpisode.where(user_id: params[:user_id], show_id: params[:episode_id])
    @show = WatchedEpisode.where(episode_id: params[:id], user_id: params[:user_id])
    @show.destroy_all
    render json: {}, status: 200
  end
end