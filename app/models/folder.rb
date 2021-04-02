class Folder < ApplicationRecord
    include BelongsToUser
    belongs_to :user, inverse_of: :folders
    acts_as_paranoid

