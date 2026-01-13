# frozen_string_literal: true

class Veiculo < ApplicationRecord
  self.table_name = "veiculo"

  belongs_to :proprietario,
             class_name: "Proprietario",
             foreign_key: :id_prop

  before_validation :normalize_fields

  # Aceita formatos:
  # - Padrão antigo: ABC1234
  # - Mercosul:      ABC1D23
  PLACA_REGEX = /\A([A-Z]{3}\d{4}|[A-Z]{3}\d[A-Z]\d{2})\z/

  validates :placa,
            presence: true,
            length: { is: 7 },
            format: { with: PLACA_REGEX, message: "deve estar no formato ABC1234 ou ABC1D23" },
            uniqueness: { case_sensitive: false, message: "já está cadastrada" }

  validates :renavam,
            presence: true,
            format: { with: /\A\d{11}\z/, message: "deve conter 11 números." },
            uniqueness: { message: "já está cadastrado" }

  private

  def normalize_fields
    self.placa = placa.to_s.upcase.gsub(/[^A-Z0-9]/, "")
    self.renavam = renavam.to_s.gsub(/\D/, "")
  end
end
