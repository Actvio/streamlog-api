class Folder < ApplicationRecord
    include BelongsToUser
    belongs_to :user, inverse_of: :folders
    acts_as_paranoid

    belongs_to :parent, class_name: Folder.name, foreign_key: 'parent_id', optional: true
    has_many :children, class_name: Folder.name, foreign_key: 'parent_id'

    has_many :