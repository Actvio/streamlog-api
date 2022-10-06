
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
      comment = FactoryBot.create(:comment, user: @user, commentable: @audio_file)

      get :show, params: {id: comment.id}
      res = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(res['id']).to eq(comment.id)
    end
  end

  describe '#create' do
    it 'should create a comment' do
      post :create, params: {comment: {
        text: 'Sample Text',
        commentable_type: AudioFile.name,
        commentable_id: @audio_file.id,
      }}
      res = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(res).to include(
        'id' => Comment.last.id,
        'text' => 'Sample Text',
        'commentable_id' => @audio_file.id,
        'commentable_type' => AudioFile.name,
      )
    end
  end

  describe '#update' do

    it 'should update comment' do
      comment = FactoryBot.create(:comment, user: @user, commentable: @audio_file)

      put :update, params: {id: comment.id, comment: {
        text: 'Sample Text Changed',
      }}
      res = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(res['text']).to eq('Sample Text Changed')
      expect(Comment.find(comment.id).text).to eq('Sample Text Changed')
    end
  end
end