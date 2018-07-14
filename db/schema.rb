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

ActiveRecord::Schema.define(version: 20180714115625) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "colors", force: :cascade do |t|
    t.string "name"
  end

  create_table "robots", force: :cascade do |t|
    t.string "name", default: ""
    t.boolean "has_sentience", default: false
    t.boolean "has_wheels", default: false
    t.boolean "has_tracks", default: false
    t.integer "number_of_rotors", default: 0
    t.bigint "color_id"
    t.bigint "shipment_id"
    t.index ["color_id"], name: "index_robots_on_color_id"
    t.index ["shipment_id"], name: "index_robots_on_shipment_id"
  end

  create_table "robots_statuses", force: :cascade do |t|
    t.bigint "robot_id"
    t.bigint "status_id"
    t.index ["robot_id"], name: "index_robots_statuses_on_robot_id"
    t.index ["status_id"], name: "index_robots_statuses_on_status_id"
  end

  create_table "shipments", force: :cascade do |t|
    t.string "address"
  end

  create_table "statuses", force: :cascade do |t|
    t.string "name"
  end

  add_foreign_key "robots", "shipments"
end
