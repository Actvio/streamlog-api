class Notification < ApplicationRecord
  include BelongsToUser
  belongs_to :user, inverse_of: :notifications
  belongs_to :source, polymorphic: true

  validates :message, presence: true

  scope :read, -> { where(marked_read: true) }
  scope :unread, -> { where(marked_read: false) }
