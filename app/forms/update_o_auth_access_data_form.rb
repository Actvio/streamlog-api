# frozen_string_literal: true

class UpdateOAuthAccessDataForm
  include ActiveModel::Model

  attr_accessor(
    :user_id,
    :provider,
    :token,
    :refresh_token,
    :expire