# frozen_string_literal: true

class UpdateOAuthAccessDataForm
  include ActiveModel::Model

  attr_accessor(
    :user_id,
    :provider,
    :token,
    :refresh_token,
    :expires_at
  )

  def save
    o_auth_access_data = OAuthAccessData.user_id_with_provider(
      user_id, provider
    ).first || OAuthAccessData.new

    persist!(o_aut