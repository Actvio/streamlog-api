# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_17_054535) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "audio_files", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.float "audio_length"
    t.bigint "user_id"
    t.index ["deleted_at"], name: "index_audio_files_on_deleted_at"
    t.index ["user_id"], name: "index_audio_files_on_user_id"
  end

  create_table "clips", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "audio_file_id"
    t.string "name"
    t.float "start_time"
    t.float "end_time"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["audio_file_id"], name: "index_clips_on_audio_file_id"
    t.index ["deleted_at"], name: "index_clips_on_deleted_at"
    t.index ["user_id"], name: "index_clips_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "text"
    t.bigint "user_id"
    t.bigint "audio_file_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.string "commentable_type"
    t.bigint "commentable_id"
    t.index ["audio_file_id"], name: "index_comments_on_audio_file_id"
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
    t.index ["deleted_at"], name: "index_comments_on_deleted_at"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "folder_items", force: :cascade do |t|
    t.string "item_type"
    t.bigint "item_id"
    t.bigint "folder_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_folder_items_on_deleted_at"
    t.index ["folder_id"], name: "index_folder_items_on_folder_id"
    t.index ["item_type", "item_id"], name: "index_folder_items_on_item_type_and_item_id"
  end

  create_table "folders", force: :cascade do |t|
    t.bigint "parent_id"
    t.bigint "user_id"
    t.string "name"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_folders_on_deleted_at"
    t.index ["parent_id"], name: "index_folders_on_parent_id"
    t.index ["user_id"], name: "index_folders_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.boolean "marked_read", default: false
    t.boolean "email_notified", default: false
    t.bigint "user_id"
    t.string "source_type"
    t.bigint "source_id"
    t.string "notification_type"
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_notified"], name: "index_notifications_on_email_notified"
    t.index ["marked_read"], name: "index_notifications_on_marked_read"
    t.index ["notification_type"], name: "index_notifications_on_notification_type"
    t.index ["source_type", "source_id"], name: "index_notifications_on_source_type_and_source_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "o_auth_access_data", force: :cascade do |t|
    t.bigint "user_id"
    t.string "provider"
    t.string "token"
    t.string "refresh_token"
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider"], name: "index_o_auth_access_data_on_provider"
    t.index ["user_id"], name: "index_o_auth_access_data_on_user_id"
  end

  create_table "other_files", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_other_files_on_deleted_at"
    t.index ["user_id"], name: "index_other_files_on_user_id"
  end

  create_table "project_attachments", force: :cascade do |t|
    t.string "item_type"
    t.bigint "item_id"
    t.bigint "project_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_project_attachments_on_deleted_at"
    t.index ["item_type", "item_id"], name: "index_project_attachments_on_item_type_and_item_id"
    t.index ["project_id"], name: "index_project_attachments_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "user_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_projects_on_deleted_at"
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email"
    t.index ["username"], name: "index_users_on_username"
  end

end
