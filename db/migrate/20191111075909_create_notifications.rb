class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.boolean :marked_read, default: false, index: true
      t.boolean :email_notified, default: false, index: t