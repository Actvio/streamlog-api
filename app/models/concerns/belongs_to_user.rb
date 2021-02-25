module BelongsToUser
  extend ActiveSupport::Concern

  included do
    validates :user, presenc