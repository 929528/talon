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

ActiveRecord::Schema.define(:version => 20130907104033) do

  create_table "access_history", :force => true do |t|
    t.integer "user_id"
    t.string  "adress"
  end

  create_table "actionstates", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "customers", :force => true do |t|
    t.string   "name"
    t.string   "fullname"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "organization_id"
    t.string   "responsible"
    t.string   "address"
    t.string   "phone"
    t.string   "fullname"
  end

  create_table "documents", :force => true do |t|
    t.datetime "date"
    t.integer  "customer_id"
    t.integer  "organization_id"
    t.integer  "actionstate_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "documents", ["actionstate_id"], :name => "index_documents_on_actionstate_id"
  add_index "documents", ["customer_id"], :name => "index_documents_on_customer_id"
  add_index "documents", ["organization_id"], :name => "index_documents_on_organization_id"

  create_table "operations", :force => true do |t|
    t.integer  "document_id"
    t.integer  "actionstate_id"
    t.integer  "talon_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "operations", ["actionstate_id"], :name => "index_operations_on_actionstate_id"
  add_index "operations", ["document_id"], :name => "index_operations_on_document_id"
  add_index "operations", ["talon_id"], :name => "index_operations_on_talon_id"

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "fullname"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.string   "fullname"
    t.float    "price"
    t.string   "idsymbol"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "states", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "talons", :force => true do |t|
    t.string   "amount"
    t.string   "barcode"
    t.integer  "product_id"
    t.integer  "state_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "talons", ["product_id"], :name => "index_talons_on_product_id"
  add_index "talons", ["state_id"], :name => "index_talons_on_state_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.integer  "role_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "remember_token"
    t.string   "fullname"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["name"], :name => "index_users_on_name", :unique => true

end
