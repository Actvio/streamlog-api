
# frozen_string_literal: true

class UserFromOmniauth
  attr_reader :auth_hash

  def initialize(auth_hash)
    @auth_hash = auth_hash.freeze

    freeze
  end

  def call
    data = auth_hash.info
    user = find_user(email: data['email'])

    return user if user.present?

    create_user(
      email: data['email'],
      first_name: data['first_name'],
      last_name: data['last_name']
    )
  end

  private

  def create_user(email:, first_name:, last_name:)
    User.create(
      email: email,
      first_name: first_name,
      last_name: last_name
    )
  end

  def find_user(email:)
    User.where(email: email).first
  end
end