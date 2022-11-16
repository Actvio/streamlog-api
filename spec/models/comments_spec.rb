require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'audio file comments' do
    it 'should be able to attach to an audio file' do
      user = FactoryBot.create(:user)
      audio_file = FactoryBot.create(:audio_file, user_id: user.id)
      comment = FactoryBot.create(:comment, user: user, c