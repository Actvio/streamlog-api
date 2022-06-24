class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.boolean :marked_read, default: false, index: true
      t.boolean :email_notified, default: false, index: true
      t.references :user, index: true
      t.references :source, polymorphic: true, index: true

      t.string :notification_type, index: true
      t.string :message

      t.timestamps
    end
  end
end
