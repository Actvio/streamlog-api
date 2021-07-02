class OtherFile < ApplicationRecord
  include FileStorage
  include ProjectAttachable
  include Commentable
  include FolderContent
  acts_as_paranoid

  include BelongsToUser
  belongs_to :user, inverse_of: :other_files