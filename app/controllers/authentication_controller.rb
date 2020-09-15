class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  def login
    @user = User.find_by(email)
    authenticate(params[:password])
  end

  def signup
    @user = User.create!(signup_params)
    authenticate(params[:password])
  end

  def google_login

  end

  def google_signup
    token = params[:token]
    authenticate_with_google(token)
  end

  private

  def authenticate(password)
    command = AuthenticateUser.call(@user, valid_user_auth?(params[:password]))

    if command.success?
      render json: command.result
    else
      unauthorized(errors: command.errors)
    end
  end

  def valid_user_auth?(password)
    return false unless [@user, password].all?

    @user.authenticate(password)
  end

  def authenticate_with_google(token)
    command = GoogleTokenVerify.call(token)

    if command.success?
      render json: command.result
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end

  def signup_params
    params.require(:authentication).permit(:username, :email, :password, :password_confirmation)
  end
end
