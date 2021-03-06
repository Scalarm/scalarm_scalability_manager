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

ActiveRecord::Schema.define(version: 20130918143410) do

  create_table "scalarm_managers", force: true do |t|
    t.string   "url"
    t.string   "service_type"
    t.integer  "worker_node_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "worker_nodes", force: true do |t|
    t.string   "url"
    t.boolean  "experiment_manager_compatible"
    t.boolean  "storage_manager_compatible"
    t.boolean  "simulation_manager_compatible"
    t.boolean  "ignored"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "user"
    t.text     "password_hashed"
  end

end
