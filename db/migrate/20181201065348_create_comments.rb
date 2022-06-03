class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :text
      t.references :user, index: true
      t.references :audio_file, index: true

      t.timestamps
    end
  end
end
