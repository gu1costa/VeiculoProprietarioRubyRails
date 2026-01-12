class ProprietariosController < ApplicationController
  before_action :set_proprietario, only: %i[ show edit update destroy ]

  # GET /proprietarios or /proprietarios.json
  def index
    @proprietarios = Proprietario.all
  end

  # GET /proprietarios/1 or /proprietarios/1.json
  def show
  end

  # GET /proprietarios/new
  def new
    @proprietario = Proprietario.new
  end

  # GET /proprietarios/1/edit
  def edit
  end

  # POST /proprietarios or /proprietarios.json
  def create
    @proprietario = Proprietario.new(proprietario_params)

    respond_to do |format|
      if @proprietario.save
        format.html { redirect_to @proprietario, notice: "Proprietario was successfully created." }
        format.json { render :show, status: :created, location: @proprietario }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @proprietario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /proprietarios/1 or /proprietarios/1.json
  def update
    respond_to do |format|
      if @proprietario.update(proprietario_params)
        format.html { redirect_to @proprietario, notice: "Proprietario was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @proprietario }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @proprietario.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /proprietarios/1 or /proprietarios/1.json
  def destroy
    @proprietario.destroy!

    respond_to do |format|
      format.html { redirect_to proprietarios_path, notice: "Proprietario was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_proprietario
      @proprietario = Proprietario.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def proprietario_params
      params.expect(proprietario: [ :cpf_cnpj, :nome, :endereco ])
    end
end
