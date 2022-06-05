class AddDeletedAtToOriginalModels < ActiveRecord::Migration[5.2]
  def change
    add_column :audio_files, :deleted_at, :datetime
    add_column :comments, :deleted_at, :datetime
    add_column 