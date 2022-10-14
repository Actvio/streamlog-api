require 'rails_helper'

RSpec.describe FoldersController, type: :controller do
  before(:each) do
    @user = FactoryBot.create(:user)

    command = AuthenticateUser.call(@user, true)
    token = command.result[:auth_token]

    request.headers.merge!({'Authorization' => token})
  end

  describe '#index' do
    it 'should return folder_item joins' do
      get :index
      res = JSON.parse(response.body)
      expect(res).to eq([])

      folder = FactoryBot.create(:folder)
      audio_file = FactoryBot.create(:audio_file)

      folder.