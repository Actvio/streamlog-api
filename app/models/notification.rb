class Notification < ApplicationRecord
  include BelongsToUser
  belongs_to :user, inverse_of: :notifications
  belongs_to :source, polymorphic: true

  validates :message, presence