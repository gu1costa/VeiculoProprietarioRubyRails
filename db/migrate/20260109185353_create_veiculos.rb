class CreateVeiculos < ActiveRecord::Migration[8.1]
  def change
    create_table :veiculos do |t|
      t.string :placa
      t.integer :renavam
      t.string :chassi

      t.timestamps
    end
  end
end
