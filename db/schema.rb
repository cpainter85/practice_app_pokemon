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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150523201354) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "pets", force: :cascade do |t|
    t.integer  "trainer_id"
    t.integer  "pokemon_id"
    t.string   "name"
    t.integer  "experience_level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pokemons", force: :cascade do |t|
    t.string   "name"
    t.string   "species"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trainers", force: :cascade do |t|
    t.string   "name"
    t.string   "country_of_origin"
    t.date     "date_of_birth"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
