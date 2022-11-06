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
      res = JSON.parse(response.body)
      expect(res['id']).to eq(Folder.last.id)
      expect(res['user_id']).to eq(@user.id)
    end
  end

  describe '#update' do
    it 'should update folder attributes' do
      folder = FactoryBot.create(:folder, user: @user)

      put :update, params: {id: folder.id, folder: {name: 'Folder 1'}}
      res = JSON.parse(response.body)
      expect(res['name']).to eq('Folder 1')
    end

    it 'should update audio files' do
      folder = FactoryBot.create(:folder, user: @user)
      audio_file1 = FactoryBot.create(:audio_file)
      audio_file2 = FactoryBot.create(:audio_file)

      folder.audio_files.push(audio_file1)
      folder.save

      put :update, params: {id: folder.id, folder: {
        folder_items_attributes: [
          {item_type: AudioFile.name, item_id: audio_file2.id}
        ]
      }}
      res = JSON.parse(response.body)
      expect(res['folder_items'].length).to eq(2)

      put :update, params: {id: folder.id, folder: {
        folder_items_attributes: [
          {id: res['folder_items'].first['id'], _destroy: true}
        ]
      }}
      res = JSON.parse(response.body)
      expect(res['folder_items'].length).to eq(1)
    end
  end
end
