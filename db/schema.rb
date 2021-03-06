# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_12_27_130922) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
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

  create_table "approvals", force: :cascade do |t|
    t.date "start_date"
    t.integer "wage"
    t.text "aid"
    t.integer "inscription_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["inscription_id"], name: "index_approvals_on_inscription_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "body"
    t.integer "profile_id", null: false
    t.integer "hunter_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hunter_id"], name: "index_comments_on_hunter_id"
    t.index ["profile_id"], name: "index_comments_on_profile_id"
  end

  create_table "hunters", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_hunters_on_email", unique: true
    t.index ["reset_password_token"], name: "index_hunters_on_reset_password_token", unique: true
  end

  create_table "inscriptions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "job_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "starred", default: false
    t.integer "status", default: 0
    t.index ["job_id"], name: "index_inscriptions_on_job_id"
    t.index ["user_id"], name: "index_inscriptions_on_user_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.text "skills"
    t.integer "position", default: 0
    t.integer "min_wage"
    t.integer "max_wage"
    t.date "deadline"
    t.string "location"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "hunter_id"
    t.integer "status", default: 0
    t.index ["hunter_id"], name: "index_jobs_on_hunter_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "full_name"
    t.string "social_name"
    t.date "birthdate"
    t.string "qualifications"
    t.text "description"
    t.text "experience"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "rejections", force: :cascade do |t|
    t.text "feedback"
    t.integer "inscription_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["inscription_id"], name: "index_rejections_on_inscription_id"
  end

  create_table "responses", force: :cascade do |t|
    t.text "comment"
    t.integer "status", default: 0
    t.integer "approval_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["approval_id"], name: "index_responses_on_approval_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "approvals", "inscriptions"
  add_foreign_key "comments", "hunters"
  add_foreign_key "comments", "profiles"
  add_foreign_key "inscriptions", "jobs"
  add_foreign_key "inscriptions", "users"
  add_foreign_key "jobs", "hunters"
  add_foreign_key "profiles", "users"
  add_foreign_key "rejections", "inscriptions"
  add_foreign_key "responses", "approvals"
end
