# app/models/proprietario.rb
# frozen_string_literal: true

class Proprietario < ApplicationRecord
  self.table_name = "proprietario"

  has_many :veiculos,
           class_name: "Veiculo",
           foreign_key: :id_prop,
           dependent: :destroy
end
