# frozen_string_literal: true

class Proprietario < ApplicationRecord
  self.table_name = "proprietario"

  has_many :veiculos,
           class_name: "Veiculo",
           foreign_key: :id_prop,
           dependent: :destroy

  before_validation :normalize_cpf_cnpj
  before_validation :normalize_uppercase_fields

  validates :cpf_cnpj, presence: true
  validates :nome, presence: true, length: { maximum: 100 }, format: { with: /\A[a-zA-ZÀ-ÿ\s]+\z/, message: "só pode conter letras e espaços" }
  validates :endereco, presence: true, format: { with: /\A[a-zA-ZÀ-ÿ0-9\s,\-\.\º\/]+\z/, message: "contém caracteres inválidos" }

  validates :cpf_cnpj,
            uniqueness: { message: "já está cadastrado" }

  validate :cpf_cnpj_must_be_valid

  private

  def normalize_cpf_cnpj
    self.cpf_cnpj = cpf_cnpj.to_s.gsub(/\D/, "")
  end

  def normalize_uppercase_fields
    self.nome = nome.to_s.upcase.strip if nome.present?
    self.endereco = endereco.to_s.upcase.strip if endereco.present?
  end

  def cpf_cnpj_must_be_valid
    return if cpf_cnpj.blank?

    case cpf_cnpj.length
    when 11
      errors.add(:cpf_cnpj, "é inválido") unless valid_cpf?(cpf_cnpj)
    when 14
      errors.add(:cpf_cnpj, "é inválido") unless valid_cnpj?(cpf_cnpj)
    else
      errors.add(:cpf_cnpj, "deve ter 11 dígitos (CPF) ou 14 dígitos (CNPJ)")
    end
  end

  def valid_cpf?(cpf)
    return false unless cpf.length == 11
    return false if cpf.chars.uniq.length == 1 # CPF com todos os números iguais

    digits = cpf.chars.map(&:to_i)

    # Calcula primeiro dígito verificador
    sum1 = 0
    9.times { |i| sum1 += digits[i] * (10 - i) }
    dv1 = 11 - (sum1 % 11)
    dv1 = 0 if dv1 >= 10
    return false unless dv1 == digits[9]

    # Calcula segundo dígito verificador
    sum2 = 0
    10.times { |i| sum2 += digits[i] * (11 - i) }
    dv2 = 11 - (sum2 % 11)
    dv2 = 0 if dv2 >= 10

    dv2 == digits[10]
  end

  def valid_cnpj?(cnpj)
    return false unless cnpj.length == 14
    return false if cnpj.chars.uniq.length == 1 # CNPJ com todos os números iguais

    digits = cnpj.chars.map(&:to_i)

    # Pesos para o primeiro dígito verificador
    w1 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
    # Pesos para o segundo dígito verificador
    w2 = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]

    # Calcula primeiro dígito verificador
    sum1 = 0
    12.times { |i| sum1 += digits[i] * w1[i] }
    r1 = sum1 % 11
    dv1 = r1 < 2 ? 0 : (11 - r1)
    return false unless dv1 == digits[12]

    # Calcula segundo dígito verificador
    sum2 = 0
    13.times { |i| sum2 += digits[i] * w2[i] }
    r2 = sum2 % 11
    dv2 = r2 < 2 ? 0 : (11 - r2)

    dv2 == digits[13]
  end
end
