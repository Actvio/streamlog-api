class CreateOAuthAccessData < ActiveRecord::Migration[5.2]
  def change
    create_table :o_auth_access_data do |t|
      t.references :user, index: true
      t.string :provider, index: 