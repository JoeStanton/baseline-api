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

ActiveRecord::Schema.define(version: 20140413143100) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "components", force: true do |t|
    t.string   "name"
    t.string   "type"
    t.string   "version"
    t.integer  "service_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.string   "slug"
    t.integer  "status",      default: 0
  end

  create_table "events", force: true do |t|
    t.integer  "service_id"
    t.integer  "component_id"
    t.integer  "host_id"
    t.integer  "incident_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",       default: 0
    t.string   "message"
    t.string   "description"
    t.string   "url"
    t.string   "author"
    t.string   "repo"
    t.string   "branch"
    t.string   "commit"
  end

  add_index "events", ["component_id"], name: "index_events_on_component_id", using: :btree
  add_index "events", ["host_id"], name: "index_events_on_host_id", using: :btree
  add_index "events", ["incident_id"], name: "index_events_on_incident_id", using: :btree
  add_index "events", ["service_id"], name: "index_events_on_service_id", using: :btree

  create_table "hosts", force: true do |t|
    t.string   "hostname"
    t.string   "ip"
    t.string   "environment"
    t.integer  "service_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",      default: 0
  end

  create_table "incidents", force: true do |t|
    t.integer  "service_id"
    t.integer  "components_id"
    t.integer  "hosts_id"
    t.datetime "resolved_at"
    t.string   "resolved_by"
    t.string   "root_cause"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",        default: 0
  end

  add_index "incidents", ["components_id"], name: "index_incidents_on_components_id", using: :btree
  add_index "incidents", ["hosts_id"], name: "index_incidents_on_hosts_id", using: :btree
  add_index "incidents", ["service_id"], name: "index_incidents_on_service_id", using: :btree

  create_table "relationships", force: true do |t|
    t.string   "source_type"
    t.integer  "source_id"
    t.string   "target_type"
    t.integer  "target_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.integer  "status",      default: 0
    t.text     "spec"
  end

end
