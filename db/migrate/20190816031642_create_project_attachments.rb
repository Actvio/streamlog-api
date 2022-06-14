
class CreateProjectAttachments < ActiveRecord::Migration[5.2]
  def change
    create_table :project_attachments do |t|
      t.references :item, polymorphic: true, index: true
      t.references :project, index: true

      t.datetime :deleted_at, index: true
      t.timestamps
    end
  end
end