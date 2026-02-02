class ProprietariosController < ApplicationController
  before_action :set_proprietario, only: %i[show edit update destroy]

  def index
    @proprietarios = Proprietario.order(:id)
    
    if params[:search].present?
      search_term = "%#{params[:search]}%"
      @proprietarios = @proprietarios.where(
        "nome ILIKE ? OR endereco ILIKE ? OR cpf_cnpj ILIKE ?",
        search_term, search_term, search_term
      )
    end
    
    @proprietarios = @proprietarios.page(params[:page]).per(10)
  end

  def show
  end

  def new
    @proprietario = Proprietario.new
  end

  def edit
  end


  def create
    @proprietario = Proprietario.new(proprietario_params)

    respond_to do |format|
      begin
        if @proprietario.save
          format.html { redirect_to proprietarios_path, notice: "Proprietário cadastrado com sucesso." }
          format.json { render :show, status: :created, location: @proprietario }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @proprietario.errors, status: :unprocessable_entity }
        end
      rescue ActiveRecord::RecordNotUnique
        @proprietario.errors.add(:cpf_cnpj, "já está cadastrado")
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @proprietario.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      begin
        if @proprietario.update(proprietario_params)
          format.html do
            redirect_to edit_proprietario_path(@proprietario),
                        notice: "Proprietário atualizado com sucesso.",
                        status: :see_other
          end
          format.json { render :show, status: :ok, location: @proprietario }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @proprietario.errors, status: :unprocessable_entity }
        end
      rescue ActiveRecord::RecordNotUnique
        @proprietario.errors.add(:cpf_cnpj, "já está cadastrado")
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @proprietario.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @proprietario.destroy
      redirect_to proprietarios_path, notice: "Proprietário removido com sucesso.", status: :see_other
    else
      redirect_to proprietarios_path, alert: @proprietario.errors.full_messages.to_sentence, status: :see_other
    end
  end

  private

  def set_proprietario
    @proprietario = Proprietario.find(params[:id])
  end

  def proprietario_params
    params.expect(proprietario: %i[cpf_cnpj nome endereco])
  end
end
