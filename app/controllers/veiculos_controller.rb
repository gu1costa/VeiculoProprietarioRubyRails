class VeiculosController < ApplicationController
  before_action :set_proprietario
  before_action :set_veiculo, only: %i[show edit update destroy]

  def index
    @veiculos = @proprietario.veiculos
  end

  def show; end

  def new
    @veiculo = @proprietario.veiculos.build
  end

  def edit; end

  def create
    @veiculo = @proprietario.veiculos.build(veiculo_params)

    if @veiculo.save
      redirect_to edit_proprietario_path(@proprietario), notice: "Veículo criado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @veiculo.update(veiculo_params)
      redirect_to edit_proprietario_path(@proprietario), notice: "Veículo atualizado com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @veiculo.destroy
    redirect_to proprietario_veiculos_path(@proprietario), notice: "Veículo removido com sucesso."
  end

  private

  def set_proprietario
    @proprietario = Proprietario.find(params[:proprietario_id])
  end

  def set_veiculo
    @veiculo = @proprietario.veiculos.find(params[:id])
  end

  def veiculo_params
    params.require(:veiculo).permit(:placa, :renavam)
  end
end
