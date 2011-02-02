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

ActiveRecord::Schema.define(:version => 20110202101406) do

  create_table "posts", :force => true do |t|
    t.integer  "number",   :null => false
    t.string   "subject",  :null => false
    t.string   "from",     :null => false
    t.datetime "time",     :null => false
    t.text     "body",     :null => false
    t.string   "ancestry"
  end

  add_index "posts", ["ancestry"], :name => "index_posts_on_ancestry"
  add_index "posts", ["number"], :name => "index_posts_on_number"

  create_table "topics", :force => true do |t|
    t.integer  "post_id"
    t.string   "subject"
    t.datetime "last_update"
  end

  create_table "translation_requests", :force => true do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "translations", :force => true do |t|
    t.integer  "post_id"
    t.string   "subject"
    t.text     "body"
    t.datetime "created_at"
  end

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
