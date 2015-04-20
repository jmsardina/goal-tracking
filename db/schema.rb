ActiveRecord::Schema.define(version: 20150416000054) do

  create_table "activities", force: :cascade do |t|
    t.text     "description"
    t.integer  "goal_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "period"
    t.boolean  "status",               default: false
    t.string   "barrier"
    t.string   "facilitator"
    t.integer  "frequency"
    t.integer  "occurences",           default: 0
    t.integer  "activity_points",      default: 0
    t.integer  "remaining_for_period"
    t.boolean  "removed",              default: false
  end

  create_table "boards", force: :cascade do |t|
    t.string   "name"
    t.integer  "group_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "comment_counter", default: 0
    t.integer  "cheer_count",     default: 0
  end

  add_index "boards", ["group_id"], name: "index_boards_on_group_id"

  create_table "cheers", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "cheerable_type"
    t.integer  "cheerable_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "cheers", ["user_id"], name: "index_cheers_on_user_id"

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "reply_counter",    default: 0
    t.integer  "cheer_count",      default: 0
  end

  create_table "feeds", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "action"
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "feeds", ["trackable_id"], name: "index_feeds_on_trackable_id"
  add_index "feeds", ["user_id"], name: "index_feeds_on_user_id"

  create_table "goals", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "status",            default: false
    t.date     "due_date"
    t.string   "motivation"
    t.string   "potential_barrier"
    t.string   "coping_strategy"
    t.string   "support"
    t.integer  "goal_points",       default: 0
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.integer  "creator_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "description"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "cheer_count",         default: 0
  end

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id"

  create_table "invitations", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.string   "invitable_type"
    t.integer  "invitable_id"
    t.string   "status",         default: "pending"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.string   "taggable_type"
    t.integer  "taggable_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "user_groups", force: :cascade do |t|
    t.integer  "group_id"
    t.integer  "member_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "invitation_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "points",                 default: 0
    t.string   "provider"
    t.string   "uid"
    t.string   "image_url"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
