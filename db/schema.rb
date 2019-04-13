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

ActiveRecord::Schema.define(version: 2019_04_13_180053) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ancestry"
    t.index ["ancestry"], name: "index_categories_on_ancestry"
  end

  create_table "categories_parameters", force: :cascade do |t|
    t.bigint "category_id"
    t.bigint "parameter_id"
    t.index ["category_id"], name: "index_categories_parameters_on_category_id"
    t.index ["parameter_id"], name: "index_categories_parameters_on_parameter_id"
  end

  create_table "parameters", force: :cascade do |t|
    t.string "name"
    t.integer "data_type"
    t.string "options", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_values", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "parameter_id"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parameter_id"], name: "index_product_values_on_parameter_id"
    t.index ["product_id"], name: "index_product_values_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_products_on_category_id"
  end

  add_foreign_key "product_values", "parameters"
  add_foreign_key "product_values", "products"
  add_foreign_key "products", "categories"
end
