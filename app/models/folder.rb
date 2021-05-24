class Folder < ApplicationRecord
    include BelongsToUser
    belongs_to :user, inverse_of: :folders
    acts_as_paranoid

    belongs_to :parent, class_name: Folder.name, foreign_key: 'parent_id', optional: true
    has_many :children, class_name: Folder.name, foreign_key: 'parent_id'

    has_many :folder_items, inverse_of: :folder, dependent: :destroy
    accepts_nested_attributes_for :folder_items, allow_destroy: true

    has_many :audio_files, through: :folder_items, inverse_of: :folders, source: :item, source_type: AudioFile.name
    has_many :clips, through: :folder_items, inverse_of: :folders, source: :item, source_type: Clip.name
    has_many :other_files, through: :folder_items, inverse_of: :folders, source: :item, source_type: OtherFile.name

    validates :name, presence: true

    def items
        folder_items.includes(:item).map(&:item)
    end

    def add_item(item)
        folder_items.push(FolderItem.new(folder: self, item: item))
    end

    def remove_item(item)
        folder_items.where(item: item).destroy_all
    end
end
