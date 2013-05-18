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

ActiveRecord::Schema.define(:version => 20130509101334) do

  create_table "assignments", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.string   "text"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "discussion_comment_reads", :force => true do |t|
    t.integer  "user_id"
    t.integer  "comment_id"
    t.datetime "read_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "discussion_comments", :force => true do |t|
    t.integer  "author_id"
    t.integer  "thread_id"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "discussion_comments", ["author_id"], :name => "index_discussion_comments_on_author_id"
  add_index "discussion_comments", ["thread_id"], :name => "index_discussion_comments_on_thread_id"

  create_table "discussion_concerns", :force => true do |t|
    t.integer  "user_id"
    t.integer  "thread_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "discussion_concerns", ["thread_id"], :name => "index_discussion_concerns_on_thread_id"
  add_index "discussion_concerns", ["user_id"], :name => "index_discussion_concerns_on_user_id"

  create_table "discussion_thread_reads", :force => true do |t|
    t.integer  "thread_id"
    t.integer  "user_id"
    t.boolean  "read",       :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "discussion_thread_reads", ["thread_id"], :name => "index_discussion_thread_reads_on_thread_id"
  add_index "discussion_thread_reads", ["user_id"], :name => "index_discussion_thread_reads_on_user_id"

  create_table "discussion_threads", :force => true do |t|
    t.string   "subject"
    t.integer  "initiator_id"
    t.datetime "last_posted_at"
    t.integer  "total_comments_post", :default => 0
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "topic_id"
    t.string   "topic_type"
  end

  add_index "discussion_threads", ["initiator_id"], :name => "index_discussion_threads_on_initiator_id"
  add_index "discussion_threads", ["topic_id"], :name => "index_discussion_threads_on_topic_id"
  add_index "discussion_threads", ["topic_type"], :name => "index_discussion_threads_on_topic_type"

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
