class ConsultasController < ApplicationController
  def index
    @placa = params[:placa].to_s.strip.upcase
    @cpf_cnpj = params[:cpf_cnpj].to_s.gsub(/\D/, "")

    if @placa.present?
      @veiculo = Veiculo.includes(:proprietario).find_by(placa: @placa)
      @proprietario = @veiculo&.proprietario
    elsif @cpf_cnpj.present?
      @proprietario = Proprietario.find_by(cpf_cnpj: @cpf_cnpj)
      @veiculos = @proprietario ? @proprietario.veiculos.order(:id) : []
    end
  end
end
