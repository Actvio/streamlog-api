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
        user = User.create_with_google_info(payload)
      end

      return {user: user, auth_token: JsonWebToken.encode(user_id: user.id)}
    else
      raise 'Failed to authenticate with Google'
    end
  end

  private

  def validate
    validator = Goo