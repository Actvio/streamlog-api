class AuthenticateUser
  prepend SimpleCommand

  def initialize(user, valid_user_auth)
    @user = user
    @valid_user_auth = valid_user_auth
  end

  def call
    return invalid_credentials if @valid_user_auth.blank?

    auth_token = JsonWe