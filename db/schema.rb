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

ActiveRecord::Schema.define(version: 20131004155327) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "catalog_amounts", force: true do |t|
    t.integer  "value"
    t.string   "symbol"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "catalog_contracts", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "customer_id"
    t.boolean  "default"
  end

  add_index "catalog_contracts", ["customer_id"], name: "index_catalog_contracts_on_customer_id", using: :btree

  create_table "catalog_customers", force: true do |t|
    t.string   "name"
    t.string   "fullname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "catalog_customers", ["name"], name: "index_catalog_customers_on_name", using: :btree

  create_table "catalog_departments", force: true do |t|
    t.string   "name"
    t.string   "fullname"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
  end

  add_index "catalog_departments", ["organization_id"], name: "index_catalog_departments_on_organization_id", using: :btree

  create_table "catalog_organizations", force: true do |t|
    t.string   "name"
    t.string   "fullname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "catalog_organizations", ["name"], name: "index_catalog_organizations_on_name", using: :btree

  create_table "catalog_products", force: true do |t|
    t.string   "name"
    t.string   "fullname"
    t.integer  "symbol"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "catalog_roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "catalog_states", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "catalog_talons", force: true do |t|
    t.integer  "amount_id"
    t.integer  "state_id"
    t.integer  "product_id"
    t.string   "barcode"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "catalog_talons", ["amount_id"], name: "index_catalog_talons_on_amount_id", using: :btree
  add_index "catalog_talons", ["barcode"], name: "index_catalog_talons_on_barcode", using: :btree
  add_index "catalog_talons", ["product_id"], name: "index_catalog_talons_on_product_id", using: :btree
  add_index "catalog_talons", ["state_id"], name: "index_catalog_talons_on_state_id", using: :btree

  create_table "catalog_users", force: true do |t|
    t.string   "name"
    t.string   "fullname"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_token"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "department_id"
  end

  add_index "catalog_users", ["department_id"], name: "index_catalog_users_on_department_id", using: :btree
  add_index "catalog_users", ["email"], name: "index_catalog_users_on_email", using: :btree
  add_index "catalog_users", ["name"], name: "index_catalog_users_on_name", using: :btree
  add_index "catalog_users", ["role_id"], name: "index_catalog_users_on_role_id", using: :btree

  create_table "documents", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "state_id"
    t.integer  "contract_id"
    t.integer  "department_id"
    t.integer  "type_id"
    t.integer  "user_id"
  end

  add_index "documents", ["contract_id"], name: "index_documents_on_contract_id", using: :btree
  add_index "documents", ["department_id"], name: "index_documents_on_department_id", using: :btree
  add_index "documents", ["state_id"], name: "index_documents_on_state_id", using: :btree
  add_index "documents", ["type_id"], name: "index_documents_on_type_id", using: :btree
  add_index "documents", ["user_id"], name: "index_documents_on_user_id", using: :btree

  create_table "operations", force: true do |t|
    t.integer  "talon_id"
    t.integer  "action_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "document_id"
  end

  add_index "operations", ["action_id"], name: "index_operations_on_action_id", using: :btree
  add_index "operations", ["document_id"], name: "index_operations_on_document_id", using: :btree
  add_index "operations", ["talon_id"], name: "index_operations_on_talon_id", using: :btree

  create_table "states", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
