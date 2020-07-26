class AuthenticateUser
  prepend SimpleCommand

  def initialize(user, valid_user_auth)
    @user = user
    @valid_user_auth = valid_user_auth
  end

  d