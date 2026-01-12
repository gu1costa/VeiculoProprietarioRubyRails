class Veiculo < ApplicationRecord
  self.table_name = "veiculo"

  belongs_to :proprietario,
             class_name: "Proprietario",
             foreign_key: :id_prop
end

