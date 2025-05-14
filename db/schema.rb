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

ActiveRecord::Schema[7.1].define(version: 2025_05_14_011909) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "course_evaluations", force: :cascade do |t|
    t.string "course_name"
    t.string "course_section"
    t.string "course_title"
    t.string "first_name"
    t.string "last_name"
    t.string "term"
    t.integer "invited_count"
    t.integer "respondent_count"
    t.float "response_ratio"
    t.float "avg_hours_prep"
    t.float "clarity_mean"
    t.float "interest_mean"
    t.float "tools_insights_mean"
    t.float "value_mean"
    t.float "recommendation_mean"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
