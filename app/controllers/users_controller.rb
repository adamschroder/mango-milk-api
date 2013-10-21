class UsersController < ApplicationController

  respond_to :html, :json

  def index
    @users = User.all
    respond_with @users
  end

  def show
    @user = User.find(params[:id])
    respond_with @user
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      render json: {}, status: 200
    else
      render json: {}, status: 422
    end
  end

  def login
    puts params[:email]
    puts params[:password]
    authorized_user = User.authenticate(params[:email],params[:password])
    puts authorized_user
    if authorized_user
      render json: {}, status 200
    else
      render json: {}, status 404
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    respond_with @user
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_with @user
  end
end
