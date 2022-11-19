require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'audio file comments' do
    it 'should be able to attach to an audio file' do
      user = FactoryBot.create(:user)
      audio_file = FactoryBot.create(:audio_file, user_id: user.id)
      comment = FactoryBot.create(:comment, user: user, commentable: audio_file)

      expect(AudioFile.find(audio_file.id).comments.first.id).to be(comment.id)
      expect(comment.audio_file.id).to be(audio_file.id)
      expect(comment.commentable.id).to be(audio_file.id)
    end
  end
end
