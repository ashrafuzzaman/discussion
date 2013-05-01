# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130501095144) do

  create_table "discussion_concerns", :force => true do |t|
    t.integer  "user_id"
    t.integer  "thread_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "discussion_concerns", ["thread_id"], :name => "index_discussion_concerns_on_thread_id"
  add_index "discussion_concerns", ["user_id"], :name => "index_discussion_concerns_on_user_id"

  create_table "discussion_message_reads", :force => true do |t|
    t.integer  "user_id"
    t.integer  "message_id"
    t.datetime "read_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "discussion_messages", :force => true do |t|
    t.integer  "author_id"
    t.integer  "thread_id"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "discussion_messages", ["author_id"], :name => "index_discussion_messages_on_author_id"
  add_index "discussion_messages", ["thread_id"], :name => "index_discussion_messages_on_thread_id"

  create_table "discussion_threads", :force => true do |t|
    t.string   "subject"
    t.integer  "initiator_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "discussion_threads", ["initiator_id"], :name => "index_discussion_threads_on_initiator_id"

  create_table "users", :force => true do |t|
    t.string   "first_name",             :default => "", :null => false
    t.string   "last_name",              :default => "", :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.date     "date_of_birth"
    t.string   "type"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
