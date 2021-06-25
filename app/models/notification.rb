class Notification < ApplicationRecord
  include BelongsToUser
  belongs_to :user, inverse_of: :notifications
  belongs_to :source, polymorphic: true

  validates :message, presence: true

  scope :read, -> { where(marked_read: true) }
  scope :unread, -> { where(marked_read: false) }

  scope :email_notified, -> { where(email_notified: true) }
  scope :not_email_notified, -> { where(email_notified: false) }

  after_create :send_push_notification

  TYPE_ADD_COMMENT = 'Ad