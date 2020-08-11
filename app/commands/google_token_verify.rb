class GoogleTokenVerify
  prepend SimpleCommand

  def initialize(token)
    @token = token
  end

  def call
    payload = validate()
    if payload.present?

      user = User.find_or_initialize_by(email: payload['email'])
      if !user.persisted?
     