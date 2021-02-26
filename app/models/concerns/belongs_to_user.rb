module BelongsToUser
  extend ActiveSupport::Concern

  included do
    validates :user, presence: :true

    # user_id should not change on update
    validates :user_id,
    