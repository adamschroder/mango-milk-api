class ShowsController < ApplicationController

  def index
    render json: Show.all
  end

  def show
    render json: Show.find(params[:id])
  end

  def create
    if Show.new(params[:show]).save
      render json: {}, status: 200
    else
      render json: {}, status: 422
    end
  end

  def update

    show = Show.find(params[:id])
    show.update_attributes(params[:show])
    render json: show
  end
end
