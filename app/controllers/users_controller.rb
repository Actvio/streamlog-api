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
    @users = User.all
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :first_name, :last_name, :avatar)
  end
end
