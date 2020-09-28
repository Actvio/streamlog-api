
class OmniauthSessionsController < ApplicationController
  skip_before_action :authenticate_request
  skip_before_action :force_json

  def create
    @user = ::UserFromOmniauth.new(request.env['omniauth.auth']).call

    return unauthorized(@user.errors.full_messages.join("\n")) unless @user.persisted?
    ::UpdateOAuthAccessDataForm.new(
      session_params(auth_hash: request.env['omniauth.auth'])
    ).save

    authenticate
  end

  private

  def authenticate
    command = ::AuthenticateUser.call(@user, true)

    if command.success?
      render html: "Connected #{command.result[:user]['email']} account. You may now close this browser tab."
    else
      render html: "Unable to connect account."
    end
  end

  def session_params(auth_hash:)
    {
      user_id: @user.id,
      provider: auth_hash['provider'],
      token: auth_hash['credentials']['token'],
      refresh_token: auth_hash['credentials']['refresh_token'],
      expires_at: auth_hash['credentials']['expires_at']
    }
  end
end
