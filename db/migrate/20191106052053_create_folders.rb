
class CreateFolders < ActiveRecord::Migration[5.2]
  def change
    create_table :folders do |t|
      t.references :parent, index: true
      t.references :user, index: true
      t.string :name

      t.datetime :deleted_at, index: true
      t.timestamps
    end
  end
end