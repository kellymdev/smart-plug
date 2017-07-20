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

ActiveRecord::Schema.define(version: 20170720023541) do

  create_table "data_files", force: :cascade do |t|
    t.string   "filename"
    t.integer  "plug_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plug_id"], name: "index_data_files_on_plug_id"
  end

  create_table "plugs", force: :cascade do |t|
    t.string   "name"
    t.string   "login_user"
    t.string   "login_password"
    t.string   "ip_address"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "readings", force: :cascade do |t|
    t.datetime "date_time"
    t.integer  "consumption"
    t.integer  "temperature"
    t.integer  "plug_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["plug_id"], name: "index_readings_on_plug_id"
  end

end
