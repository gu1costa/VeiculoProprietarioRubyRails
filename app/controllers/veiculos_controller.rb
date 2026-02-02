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

    begin
      if @veiculo.save
        redirect_to edit_proprietario_path(@proprietario), notice: "Veículo criado com sucesso."
      else
        render :new, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotUnique
      aplicar_erros_de_unicidade(@veiculo)
      render :new, status: :unprocessable_entity
    end
  end


  def update
    begin
      if @veiculo.update(veiculo_params)
        redirect_to edit_proprietario_path(@proprietario), notice: "Veículo atualizado com sucesso."
      else
        render :edit, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotUnique
      aplicar_erros_de_unicidade(@veiculo, ignorar_id: @veiculo.id)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @veiculo.destroy
    redirect_to edit_proprietario_path(@proprietario),
                notice: "Veículo removido com sucesso.",
                status: :see_other
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

  def aplicar_erros_de_unicidade(veiculo, ignorar_id: nil)
    placa_normalizada = veiculo.placa.to_s.upcase.gsub(/[^A-Z0-9]/, "")
    renavam_normalizado = veiculo.renavam.to_s.gsub(/\D/, "")

    scope = Veiculo.all
    scope = scope.where.not(id: ignorar_id) if ignorar_id.present?

    if placa_normalizada.present? && scope.where("upper(placa) = ?", placa_normalizada).exists?
      veiculo.errors.add(:placa, "já está cadastrada")
    end

    if renavam_normalizado.present? && scope.where(renavam: renavam_normalizado).exists?
      veiculo.errors.add(:renavam, "já está cadastrado")
    end

    if veiculo.errors.empty?
      veiculo.errors.add(:base, "Placa ou RENAVAM já estão cadastrados")
    end
  end
end
