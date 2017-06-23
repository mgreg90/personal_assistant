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

ActiveRecord::Schema.define(version: 20161203041122) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contexts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "reminder_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["reminder_id"], name: "index_contexts_on_reminder_id", using: :btree
    t.index ["user_id"], name: "index_contexts_on_user_id", using: :btree
  end

  create_table "reminders", force: :cascade do |t|
    t.text     "message"
    t.string   "status"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_reminders_on_user_id", using: :btree
  end

  create_table "schedules", force: :cascade do |t|
    t.datetime "next_occurrence"
    t.datetime "last_occurrence"
    t.string   "schedule_type"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "interval"
    t.integer  "day_of_week"
    t.string   "week_of_month"
    t.string   "date_of_month"
    t.string   "timezone"
    t.integer  "reminder_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["reminder_id"], name: "index_schedules_on_reminder_id", using: :btree
  end

  create_table "slack_messages", force: :cascade do |t|
    t.string   "timezone"
    t.string   "body"
    t.string   "channel"
    t.integer  "context_id"
    t.integer  "reminder_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["context_id"], name: "index_slack_messages_on_context_id", using: :btree
    t.index ["reminder_id"], name: "index_slack_messages_on_reminder_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "slack_user_id"
    t.string   "slack_team_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_foreign_key "contexts", "reminders"
  add_foreign_key "contexts", "users"
  add_foreign_key "reminders", "users"
  add_foreign_key "schedules", "reminders"
  add_foreign_key "slack_messages", "contexts"
  add_foreign_key "slack_messages", "reminders"
end
