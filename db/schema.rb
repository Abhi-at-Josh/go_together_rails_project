# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_01_30_060924) do
  create_table "admins", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
  end

  create_table "bookings", force: :cascade do |t|
    t.integer "ride_id", null: false
    t.integer "rating_id"
    t.string "status", default: "booked"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rating_id"], name: "index_bookings_on_rating_id"
    t.index ["ride_id"], name: "index_bookings_on_ride_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "ride_id", null: false
    t.integer "user_id", null: false
    t.integer "rating", null: false
    t.text "review"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ride_id"], name: "index_ratings_on_ride_id"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "rides", force: :cascade do |t|
    t.integer "passenger_id"
    t.integer "rider_id"
    t.string "starting_coordinates"
    t.string "ending_coordinates"
    t.decimal "price"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "phone_no"
    t.string "email"
    t.string "password_digest"
    t.string "gender"
    t.integer "age"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "bookings", "ratings"
  add_foreign_key "bookings", "rides"
  add_foreign_key "ratings", "rides"
  add_foreign_key "ratings", "users"
end
