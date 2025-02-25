ActiveRecord::Schema[7.2].define(version: 2025_02_12_110543) do
  create_table "admins", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
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

  create_table "ride_requests", force: :cascade do |t|
    t.integer "requester_id", null: false
    t.string "starting_coordinates", null: false
    t.string "ending_coordinates", null: false
    t.time "ride_time", null: false
    t.string "status", default: "pending", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "price", precision: 10, scale: 2
    t.index ["requester_id"], name: "index_ride_requests_on_requester_id"
    t.index ["status"], name: "index_ride_requests_on_status"
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
    t.time "ride_time", default: "2000-01-01 00:00:00", null: false
    t.integer "ride_request_id"
    t.index ["ride_request_id"], name: "index_rides_on_ride_request_id"
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
  add_foreign_key "ride_requests", "users", column: "requester_id"
  add_foreign_key "rides", "ride_requests"
end

