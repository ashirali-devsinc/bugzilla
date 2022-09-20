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

ActiveRecord::Schema[7.0].define(version: 2022_09_20_102159) do
  create_table "bugs", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.date "deadline"
    t.integer "nature"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_bugs_on_user_id"
  end

  create_table "manual_state_machines", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "model"
    t.json "changes_made"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_manual_state_machines_on_user_id"
  end

  create_table "project_bugs", force: :cascade do |t|
    t.integer "bug_id", null: false
    t.integer "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bug_id"], name: "index_project_bugs_on_bug_id"
    t.index ["project_id"], name: "index_project_bugs_on_project_id"
  end

  create_table "project_developers", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_project_developers_on_project_id"
    t.index ["user_id"], name: "index_project_developers_on_user_id"
  end

  create_table "project_qas", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_project_qas_on_project_id"
    t.index ["user_id"], name: "index_project_qas_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "creator_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "user_type"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "manual_state_machines", "users"
  add_foreign_key "project_bugs", "bugs"
  add_foreign_key "project_bugs", "projects"
  add_foreign_key "project_developers", "projects"
  add_foreign_key "project_developers", "users"
  add_foreign_key "project_qas", "projects"
  add_foreign_key "project_qas", "users"
end
