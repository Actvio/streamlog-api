
require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  before(:each) do
    @user = init_user(request)
    @audio_file = FactoryBot.create(:audio_file, user: @user)
  end

  describe '#index' do
    it 'should return comments' do
      get :index
      res = JSON.parse(response.body)
      expect(res).to eq([])

      comment = FactoryBot.create(:comment, user: @user, commentable: @audio_file)

      get :index
      res = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(res.length).to eq(1)
      expect(res.first['id']).to eq(comment.id)
    end

    it 'should return comments for an audio file' do
      get :index
      res = JSON.parse(response.body)
      expect(res).to eq([])

      @audio_file2 = FactoryBot.create(:audio_file, user: @user)

      comment = FactoryBot.create(:comment, user: @user, commentable: @audio_file)
      comment2 = FactoryBot.create(:comment, user: @user, commentable: @audio_file2)

      get :index, params: {commentable_id: @audio_file.id, commentable_type: AudioFile.name}
      res = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(res.length).to eq(1)
      expect(res.first['id']).to eq(comment.id)
    end
  end

  describe '#show' do
    it 'should return comments' do