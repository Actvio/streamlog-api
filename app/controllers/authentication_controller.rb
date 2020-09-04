class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  def login
    @user = User.find_by(email)
    authenticate(params[:password])
  end

  def signup
    @user = User.create!(signup_params)
    aut