ActiveRecord::Schema[7.2].define(version: 2026_03_16_142439) do
  enable_extension "plpgsql"

  create_table "posts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title", null: false
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "display_name", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.integer "failed_logins_count", default: 0, null: false
    t.datetime "lock_expires_at"
    t.string "unlock_token"
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.string "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.index "lower((email)::text)", name: "index_users_on_lower_email", unique: true
    t.index ["remember_me_token"], name: "index_users_on_remember_me_token", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "posts", "users"
end
