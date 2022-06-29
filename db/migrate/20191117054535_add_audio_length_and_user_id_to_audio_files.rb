class AddAudioLengthAndUserIdToAudioFiles < ActiveRecord::Migration[5.2]
  def change
    add_column :audio_files, :audio_length, :float

    add_column :audio_files, :user_id, :bigint
    add_index :audio_files, :user_id
  end
end
