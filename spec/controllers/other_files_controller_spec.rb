
require 'rails_helper'

RSpec.describe OtherFilesController, type: :controller do
  before(:each) do
    @user = init_user(request)
  end

  describe '#index' do
    it 'should return other_files' do
      get :index
      res = JSON.parse(response.body)
      expect(res).to eq([])

      other_file = FactoryBot.create(:other_file, user: @user)

      other_file.save

      get :index
      res = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(res.length).to eq(1)
      expect(res.first['id']).to eq(other_file.id)
    end
  end

  describe '#show' do
    it 'should return other_files' do
      other_file = FactoryBot.create(:other_file, user: @user)

      other_file.save

      get :show, params: {id: other_file.id}
      res = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(res['id']).to eq(other_file.id)
    end
  end

  describe '#create' do
    it 'should create a other_file' do
      post :create, params: {other_file: {
        name: 'Sample Name',
      }}
      res = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(res['id']).to eq(OtherFile.last.id)
    end
  end

  describe '#update' do
    it 'should update other_file' do
      other_file = FactoryBot.create(:other_file, user: @user)

      other_file.save

      put :update, params: {id: other_file.id, other_file: {
        name: 'Sample Name',
      }}
      res = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(res['id']).to eq(other_file.id)
    end
  end

  describe '#destroy' do
    it 'should destroy other_file' do
      other_file = FactoryBot.create(:other_file, user: @user)

      other_file.save

      delete :destroy, params: {id: other_file.id}
      res = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(res['id']).to eq(other_file.id)

      expect(OtherFile.count).to eq(0)
      expect(OtherFile.with_deleted.first.id).to eq(other_file.id)
    end
  end
end