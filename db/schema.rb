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

ActiveRecord::Schema.define(version: 2021_12_04_012409) do

  create_table "articles", force: :cascade do |t|
    t.string "url"
    t.string "headline"
    t.integer "summary_id"
    t.integer "source_id"
    t.boolean "public"
    t.integer "user_id"
    t.boolean "email"
    t.boolean "text"
    t.boolean "reread_list"
    t.datetime "read_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "read"
  end

  create_table "summaries", force: :cascade do |t|
    t.string "body"
    t.integer "user_id"
    t.integer "article_id"
    t.boolean "public"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "username"
    t.string "phone"
    t.boolean "private"
    t.integer "articles_count"
    t.integer "summaries_count"
    t.integer "folders_count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
