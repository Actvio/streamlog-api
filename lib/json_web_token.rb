class JsonWebToken
  class << self
    def encode(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, Rails.application.secrets.secret_key_base, 'none')
      # figure out how to use credentials to store a secret key for this
    end

    def decode(token)
      body = JWT.decode(token, Rails.application.secrets.secret_key_base, false)[0]
      HashWithIndifferentAccess.new body
    rescue
      nil
    end
  end
end
