class AddDeletedAtToOriginalModels < ActiveRecord::Migration[5.2]
  def change
    add_column :audio_files, :deleted_at, :datetime
    add_column :comments, :deleted_at, :datetime
    add_column :users, :deleted_at, :datetime

    add_index :audio_files, :deleted_at
    add_index :comments, :deleted_at
    add_index :users, :deleted_at
  end
end
