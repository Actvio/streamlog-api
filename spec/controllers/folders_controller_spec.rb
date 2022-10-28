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

      folder.audio_files.push(audio_file)
      folder.save

      get :index
      res = JSON.parse(response.body)
      expect(res.length).to eq(1)

      data = res.first
      expect(data['folder_items'].length).to eq(1)
      expect(data['folder_items'].first['item_id']).to eq(audio_file.id)
      expect(data['folder_items'].first['item_type']).to eq(AudioFile.name)
      expect(data['folder_items'].first['folder_id']).to eq(folder.id)
    end
  end

  describe '#show' do
    it 'should return folder items' do
      folder = FactoryBot.create(:folder)
      audio_file = FactoryBot.create(:audio_file)

      folder.audio_files.push(audio_file)
      folder.save

      get :show, params: {id: folder.id}
      res = JSON.parse(response.body)

      data = res
      expect(data['folder_items'].length).to eq(1)
      expect(data['folder_items'].first['item_id']).to eq(audio_file.id)
      expect(data['folder_items'].first['item_type']).to eq(AudioFile.name)
      expect(data['folder_items'].first['folder_id']).to eq(folder.id)

      expect(data['items'].length).to eq(1)
      expect(data['items'].first['id']).to eq(audio_file.id)
    end
  end

  describe '#create' do
    it 'should create a folder' do
      post :create, params: {folder: {name: 'Folder 1'}}
      res = J