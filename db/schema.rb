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

ActiveRecord::Schema.define(version: 20180224203101) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conditions", force: :cascade do |t|
    t.date "date"
    t.decimal "max_temperature"
    t.decimal "mean_temperature"
    t.decimal "min_temperature"
    t.decimal "mean_humidity"
    t.decimal "mean_visibility"
    t.decimal "mean_wind_speed"
    t.decimal "mean_precipitation"
    t.integer "zip_code"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "items", force: :cascade do |t|
    t.string "title"
    t.integer "status", default: 0
    t.text "description"
    t.decimal "price"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.string "slug"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "quantity"
    t.bigint "order_id"
    t.bigint "item_id"
    t.index ["item_id"], name: "index_order_items_on_item_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.float "total"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "stations", force: :cascade do |t|
    t.string "name"
    t.integer "dock_count"
    t.string "city"
    t.date "installation_date"
    t.string "slug"
    t.decimal "latitude", precision: 15, scale: 10
    t.decimal "longitude", precision: 15, scale: 10
    t.index ["slug"], name: "index_stations_on_slug", unique: true
  end

  create_table "trips", force: :cascade do |t|
    t.integer "duration"
    t.integer "bike_id"
    t.string "subscription_type"
    t.integer "start_station_id"
    t.datetime "start_date"
    t.integer "end_station_id"
    t.datetime "end_date"
    t.integer "zip_code"
    t.bigint "condition_id"
    t.bigint "station_id"
    t.index ["condition_id"], name: "index_trips_on_condition_id"
    t.index ["station_id"], name: "index_trips_on_station_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0
  end

  add_foreign_key "order_items", "items"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "users"
  add_foreign_key "trips", "conditions"
  add_foreign_key "trips", "stations"
end
