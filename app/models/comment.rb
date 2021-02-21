
class Comment < ApplicationRecord
  include BelongsToUser
  belongs_to :user, inverse_of: :comments
  acts_as_paranoid

  belongs_to :commentable, polymorphic: true, inverse_of: :comments
  after_create :queue_notifications

  validates :text, presence: true

  def audio_file
    return nil unless commentable_type == 'AudioFile'
    AudioFile.find_by(id: commentable_id)
  end

  private

  def queue_notifications
    message = "New comment from #{user.username}:\n#{text}"
    NotificationService.new.create_notifications(source: self, message: message, notification_type: Notification::TYPE_ADD_COMMENT)
  end
end