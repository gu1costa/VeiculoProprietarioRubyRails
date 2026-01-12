require "test_helper"

class ProprietariosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @proprietario = proprietarios(:one)
  end

  test "should get index" do
    get proprietarios_url
    assert_response :success
  end

  test "should get new" do
    get new_proprietario_url
    assert_response :success
  end

  test "should create proprietario" do
    assert_difference("Proprietario.count") do
      post proprietarios_url, params: { proprietario: { cpf_cnpj: @proprietario.cpf_cnpj, endereco: @proprietario.endereco, nome: @proprietario.nome } }
    end

    assert_redirected_to proprietario_url(Proprietario.last)
  end

  test "should show proprietario" do
    get proprietario_url(@proprietario)
    assert_response :success
  end

  test "should get edit" do
    get edit_proprietario_url(@proprietario)
    assert_response :success
  end

  test "should update proprietario" do
    patch proprietario_url(@proprietario), params: { proprietario: { cpf_cnpj: @proprietario.cpf_cnpj, endereco: @proprietario.endereco, nome: @proprietario.nome } }
    assert_redirected_to proprietario_url(@proprietario)
  end

  test "should destroy proprietario" do
    assert_difference("Proprietario.count", -1) do
      delete proprietario_url(@proprietario)
    end

    assert_redirected_to proprietarios_url
  end
end
