
class FolderItem < ApplicationRecord
    acts_as_paranoid

    belongs_to :item, polymorphic: true, inverse_of: :folder_items
    belongs_to :folder, inverse_of: :folder_items
end