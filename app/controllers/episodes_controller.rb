class EpisodesController < ApplicationController

  def index
    render json: Episode.all
  end

  def show
    render json: Episode.find(params[:id])
  end

  def create
    if Episode.new(params[:episode]).save
      render json: {}, status: 200
    else
      render json: {}, status: 422
    end
  end

  def update

    episode = Episode.find(params[:id])
    episode.update_attributes(params[:episode])
    render json: episode
  end
end
