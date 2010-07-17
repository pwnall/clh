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

ActiveRecord::Schema.define(:version => 20100717075712) do

  create_table "geocode_fetches", :force => true do |t|
    t.string   "location",   :limit => 128, :null => false
    t.string   "city",       :limit => 32,  :null => false
    t.binary   "response",                  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "geocode_fetches", ["location", "city"], :name => "index_geocode_fetches_on_location_and_city", :unique => true

  create_table "listings", :force => true do |t|
    t.integer  "price",                                                    :null => false
    t.integer  "rooms",                                                    :null => false
    t.datetime "posted_at",                                                :null => false
    t.string   "cl_url",    :limit => 128,                                 :null => false
    t.string   "title",     :limit => 128,                                 :null => false
    t.string   "location",  :limit => 128,                                 :null => false
    t.string   "city",      :limit => 32,                                  :null => false
    t.decimal  "lat",                      :precision => 14, :scale => 10, :null => false
    t.decimal  "lng",                      :precision => 14, :scale => 10, :null => false
  end

  add_index "listings", ["cl_url"], :name => "index_listings_on_cl_url", :unique => true

  create_table "page_fetches", :force => true do |t|
    t.string   "url",        :limit => 128,      :null => false
    t.datetime "expires_at",                     :null => false
    t.binary   "contents",   :limit => 16777215, :null => false
  end

  add_index "page_fetches", ["url"], :name => "index_page_fetches_on_url", :unique => true

end
