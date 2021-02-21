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

    persist!(o_auth_access_data)
  end

  def save!
    raise NotImplementedError.new('#save!')
  end

  private

  def o_auth_params
    {
      user_id:        user_id,
      provider:       provider,
      token:          token,
      refresh_token:  refresh_token,
      expires_at:     Time.at(expires_at).to_datetime
    }
  end

  def persist!(o_auth_access_data)
    o_auth_access_data.update_attributes(o_auth_params)
  end
end
