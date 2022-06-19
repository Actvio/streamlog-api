class CreateOtherFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :other_files do |t|
      t.string :name
      t.references :user, index: true

      t.datetime :dele