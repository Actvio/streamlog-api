class GoogleTokenVerify
  prepend SimpleCommand

  def initialize(token)
    @token = token
  end

  def call
    payload = validate()
    if payload.present?

      user = U