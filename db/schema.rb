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

ActiveRecord::Schema.define(:version => 20140516040134) do

  create_table "feedbacks", :force => true do |t|
    t.integer  "user_id"
    t.text     "feedback"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "feed_id"
  end

  create_table "matches", :force => true do |t|
    t.datetime "date"
    t.string   "team_a"
    t.string   "team_b"
    t.integer  "score_a"
    t.integer  "score_b"
    t.string   "day"
  end

  create_table "predictions", :force => true do |t|
    t.integer  "match_id"
    t.integer  "user_id"
    t.integer  "predict_score_a"
    t.integer  "predict_score_b"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.boolean  "bet",             :default => false
  end

  create_table "users", :force => true do |t|
    t.string  "username"
    t.string  "password"
    t.boolean "admin",    :default => false
  end

end
