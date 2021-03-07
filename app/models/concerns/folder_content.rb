module FolderContent
  extend ActiveSupport::Concern

  included do
    has_many :folder_items, as: :item, inverse_of: :item # , dependent: :destroy
    has_many :folders, through: :folder_items
  end
end
