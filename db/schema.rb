# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_06_05_010946) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_invitations", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "invited_by_id"
    t.string "token", null: false
    t.string "name", null: false
    t.string "email", null: false
    t.jsonb "roles", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_account_invitations_on_account_id"
    t.index ["invited_by_id"], name: "index_account_invitations_on_invited_by_id"
    t.index ["token"], name: "index_account_invitations_on_token", unique: true
  end

  create_table "account_users", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "user_id", null: false
    t.jsonb "roles", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "accounts", force: :cascade do |t|
    t.bigint "owner_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "account_type"
  end

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "announcements", force: :cascade do |t|
    t.string "kind"
    t.datetime "published_at"
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "candidates", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "owner_id"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone_number"
    t.string "gender"
    t.date "birth_date"
    t.string "location"
    t.string "source_type"
    t.boolean "is_employee", default: false, null: false
    t.jsonb "custom_fields", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_candidates_on_account_id"
    t.index ["owner_id"], name: "index_candidates_on_owner_id"
  end

  create_table "departments", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "owner_id"
    t.string "name"
    t.integer "jobs_count", default: 0
    t.string "industry"
    t.string "location"
    t.string "website"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "job_pipeline_stages", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "job_pipeline_id", null: false
    t.string "name"
    t.string "kind"
    t.integer "display_order"
    t.boolean "is_protected", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_job_pipeline_stages_on_account_id"
    t.index ["job_pipeline_id"], name: "index_job_pipeline_stages_on_job_pipeline_id"
  end

  create_table "job_pipelines", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "name"
    t.boolean "is_default", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_job_pipelines_on_account_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "department_id"
    t.bigint "job_pipeline_id"
    t.bigint "owner_id"
    t.string "position_name"
    t.integer "headcount"
    t.string "contract"
    t.integer "salary_min"
    t.integer "salary_max"
    t.string "currency"
    t.string "frequency"
    t.string "location"
    t.boolean "is_remote", default: false, null: false
    t.string "visibility"
    t.integer "matches_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_jobs_on_account_id"
    t.index ["department_id"], name: "index_jobs_on_department_id"
    t.index ["job_pipeline_id"], name: "index_jobs_on_job_pipeline_id"
    t.index ["owner_id"], name: "index_jobs_on_owner_id"
  end

  create_table "match_histories", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "match_id", null: false
    t.bigint "job_id", null: false
    t.bigint "candidate_id", null: false
    t.bigint "job_pipeline_stage_id"
    t.datetime "pending_at"
    t.datetime "processing_at"
    t.datetime "processed_at"
    t.datetime "dropped_at"
    t.string "drop_reasons", default: [], array: true
    t.integer "display_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["account_id"], name: "index_match_histories_on_account_id"
    t.index ["candidate_id"], name: "index_match_histories_on_candidate_id"
    t.index ["job_id"], name: "index_match_histories_on_job_id"
    t.index ["job_pipeline_stage_id"], name: "index_match_histories_on_job_pipeline_stage_id"
    t.index ["match_id"], name: "index_match_histories_on_match_id"
    t.index ["user_id"], name: "index_match_histories_on_user_id"
  end

  create_table "matches", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "job_id", null: false
    t.bigint "candidate_id", null: false
    t.bigint "job_pipeline_stage_id"
    t.datetime "pending_at"
    t.datetime "processing_at"
    t.datetime "processed_at"
    t.datetime "dropped_at"
    t.string "drop_reasons", default: [], array: true
    t.integer "display_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["account_id"], name: "index_matches_on_account_id"
    t.index ["candidate_id"], name: "index_matches_on_candidate_id"
    t.index ["job_id"], name: "index_matches_on_job_id"
    t.index ["job_pipeline_stage_id"], name: "index_matches_on_job_pipeline_stage_id"
    t.index ["user_id"], name: "index_matches_on_user_id"
  end

  create_table "public_jobs", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "job_id"
    t.bigint "department_id"
    t.bigint "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_public_jobs_on_account_id"
    t.index ["department_id"], name: "index_public_jobs_on_department_id"
    t.index ["job_id"], name: "index_public_jobs_on_job_id"
    t.index ["owner_id"], name: "index_public_jobs_on_owner_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false, null: false
    t.string "first_name"
    t.string "last_name"
    t.datetime "accepted_terms_at"
    t.datetime "accepted_privacy_at"
    t.datetime "announcements_read_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "account_invitations", "accounts"
  add_foreign_key "account_invitations", "users", column: "invited_by_id"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "match_histories", "users"
  add_foreign_key "matches", "users"
end
