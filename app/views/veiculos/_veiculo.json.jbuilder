json.extract! veiculo, :id, :placa, :renavam
json.proprietario_id veiculo.id_prop

json.url proprietario_veiculo_url(veiculo.proprietario, veiculo, format: :json)
