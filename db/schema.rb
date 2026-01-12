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

ActiveRecord::Schema[8.1].define(version: 2026_01_09_185353) do
  create_schema "cadastro"

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "proprietario", id: :serial, force: :cascade do |t|
    t.string "cpf_cnpj", limit: 14, null: false
    t.text "endereco", null: false
    t.string "nome", limit: 100, null: false

    t.unique_constraint ["cpf_cnpj"], name: "proprietario_cpf_cnpj_key"
  end

  create_table "veiculo", id: :serial, force: :cascade do |t|
    t.integer "id_prop", null: false
    t.string "placa", limit: 7, null: false
    t.string "renavam", limit: 11, null: false

    t.unique_constraint ["placa"], name: "veiculo_placa_key"
    t.unique_constraint ["renavam"], name: "veiculo_renavam_key"
  end

  create_table "veiculos", force: :cascade do |t|
    t.string "chassi"
    t.datetime "created_at", null: false
    t.string "placa"
    t.integer "renavam"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "veiculo", "proprietario", column: "id_prop", name: "veiculo_id_prop_fkey", on_delete: :cascade
end
