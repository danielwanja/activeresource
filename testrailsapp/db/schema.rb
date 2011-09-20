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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110815231253) do

  create_table "courses", :force => true do |t|
    t.integer  "job_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.string   "city"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employees", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "job_id"
    t.integer  "department_id"
    t.integer  "manager_id"
    t.datetime "hire_date"
    t.integer  "salary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobs", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rc_data_type_tables", :force => true do |t|
    t.string   "a_string"
    t.text     "a_text"
    t.integer  "an_integer"
    t.float    "a_float"
    t.decimal  "a_decimal"
    t.datetime "a_datetime"
    t.datetime "a_timestamp"
    t.time     "a_time"
    t.date     "a_date"
    t.binary   "a_binary"
    t.boolean  "a_boolean"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
