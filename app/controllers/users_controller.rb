class UsersController < ApplicationController
  def create
    @user = User.create!(user_params)
    render 'show'
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.update(user_params)
    render 'show'
  end

  def index
    @users = User