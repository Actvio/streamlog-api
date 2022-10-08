require 'rails_helper'

RSpec.describe FoldersController, type: :controller do
  before(:each) do
    @user = FactoryBot.create(:user)

    command = AuthenticateUser.call(@user, true)
    token = comman