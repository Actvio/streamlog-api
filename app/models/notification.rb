class Notification < ApplicationRecord
  include BelongsToUser
  belongs_to :user, i