# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_31_190045) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.integer "api_id"
    t.string "name"
    t.string "url"
    t.datetime "start_date"
  end

  create_table "game_genres", force: :cascade do |t|
    t.integer "game_id"
    t.integer "genre_id"
  end

  create_table "games", force: :cascade do |t|
    t.integer "api_id"
    t.string "name"
    t.datetime "release_date"
    t.string "url"
    t.string "cover_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "genres", force: :cascade do |t|
    t.integer "api_id"
    t.string "name"
  end

  create_table "ingredients", force: :cascade do |t|
    t.integer "recipe_id"
    t.integer "reagent_id"
    t.integer "quantity"
  end

  create_table "involved_companies", force: :cascade do |t|
    t.integer "api_id"
    t.integer "game_id"
    t.integer "company_id"
    t.boolean "developer"
    t.boolean "publisher"
    t.boolean "supporting"
  end

  create_table "items", force: :cascade do |t|
    t.integer "user_game_id"
    t.string "name"
    t.string "note"
  end

  create_table "loadout_items", force: :cascade do |t|
    t.integer "loadout_id"
    t.integer "item_id"
    t.integer "quantity"
  end

  create_table "loadout_tasks", force: :cascade do |t|
    t.integer "loadout_id"
    t.integer "task_id"
  end

  create_table "loadouts", force: :cascade do |t|
    t.integer "user_game_id"
    t.string "name"
  end

  create_table "recipes", force: :cascade do |t|
    t.integer "item_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.integer "user_game_id"
    t.string "name"
    t.text "description"
  end

  create_table "twitch_tokens", force: :cascade do |t|
    t.string "token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_games", force: :cascade do |t|
    t.integer "user_id"
    t.integer "game_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
