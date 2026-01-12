json.extract! veiculo, :id, :placa, :renavam, :chassi, :created_at, :updated_at
json.url veiculo_url(veiculo, format: :json)
