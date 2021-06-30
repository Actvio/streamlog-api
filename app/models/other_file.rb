class OtherFile < ApplicationRecord
  include FileStorage
  include ProjectAttachable
  include Commentable
  include FolderContent
  acts_as_paranoid

