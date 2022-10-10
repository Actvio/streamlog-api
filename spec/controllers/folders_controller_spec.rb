require 'rails_helper'

RSpec.describe FoldersController, type: :controller do
  before(:each) do
    @user = FactoryBot.create(:user)

    command = AuthenticateUser.call(@user, true)
    token = command.result[:auth_token]

    request.headers.merge!({'Authorization' => token})
  end

  describe '