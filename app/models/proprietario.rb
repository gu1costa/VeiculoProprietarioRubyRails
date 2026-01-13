# frozen_string_literal: true

class Proprietario < ApplicationRecord
  self.table_name = "proprietario"

  has_many :veiculos,
           class_name: "Veiculo",
           foreign_key: :id_prop,
           dependent: :destroy

  before_validation :normalize_cpf_cnpj

  validates :cpf_cnpj, presence: true
  validates :nome, presence: true, length: { maximum: 100 }
  validates :endereco, presence: true

  validates :cpf_cnpj,
            uniqueness: { message: "já está cadastrado" }

  validate :cpf_cnpj_must_be_valid_length

  private

  def normalize_cpf_cnpj
    self.cpf_cnpj = cpf_cnpj.to_s.gsub(/\D/, "")
  end

  def cpf_cnpj_must_be_valid_length
    return if cpf_cnpj.blank?

    unless cpf_cnpj.length == 11 || cpf_cnpj.length == 14
      errors.add(:cpf_cnpj, "deve ter 11 dígitos (CPF) ou 14 dígitos (CNPJ)")
    end
  end
end
