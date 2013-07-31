class ShowsController < ApplicationController

  def index
    if params[:search]

      @shows = Show.search(params[:search])

      if @shows
        render json: @shows, status: 200
      else
        render json: {}, status: 422
      end

    else
      render json: Show.find(:all), status: 200
    end
  end

  def show
    render json: Show.find(params[:id])
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
