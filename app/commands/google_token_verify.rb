class GoogleTokenVerify
  prepend SimpleCommand

  def initialize(token)
    @token = token
  end

  d