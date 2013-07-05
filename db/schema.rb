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

ActiveRecord::Schema.define(version: 20130703183243) do

  create_table "categories", force: true do |t|
    t.string "name"
    t.string "subtitle"
  end

  create_table "invitations", force: true do |t|
    t.string  "party_name"
    t.string  "email"
    t.integer "number_invited"
    t.string  "address1"
    t.string  "address2"
    t.string  "city"
    t.string  "state"
    t.string  "zip"
  end

  create_table "locations", force: true do |t|
    t.integer "category_id"
    t.string  "name"
    t.text    "description"
    t.integer "link"
  end

  create_table "rsvps", force: true do |t|
    t.string  "party_name"
    t.string  "number_attending"
    t.integer "invitation_id"
    t.string  "gift"
  end

end
