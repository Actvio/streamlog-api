class Folder < ApplicationRecord
    include BelongsToUser
    belongs_to :user, inverse_of: :folders
    acts_as_paranoid

    belongs_to :parent, class_name: Folder.name, foreign_key: 'parent_id', optional: true
    has_many :children, class_name: Folder.name, foreign_key: 'parent_id'

    has_many :folder_items, inverse_of: :folder, dependent: :destroy
    accepts_nested_attributes_for :folder_items, allow_destroy: true

    has_many :audio_files, through: :