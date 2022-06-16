
class CreateFolderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :folder_items do |t|
      t.references :item, polymorphic: true, index: true
      t.references :folder, index: true

      t.datetime :deleted_at, index: true
      t.timestamps
    end
  end
end