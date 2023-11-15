class PermissaoUsuariosController < ApplicationController
  before_action :authenticate_usuario!
  before_action :checar_secretario

  before_action :setar_usuario
  before_action :checar_aluno, only: [:criar_permissao]

  def listar_permissoes
    @permissao_usuarios = @usuario.permissao_usuarios
    render :index
  end

  def criar_permissao
    @permissao_usuario = @usuario.permissao_usuarios.new(permissao_usuario_params)
    
    if @permissao_usuario.save
      render :show, status: :created
    else
      render json: @permissao_usuario.errors, status: :unprocessable_entity
    end 
  end

  private

  def checar_aluno
    if @usuario.tipo != 'aluno'
      render json: { error: 'Usuário não é um aluno' }, status: :unprocessable_entity
      return
    end

    if @usuario.adulto?
      render json: { error: 'Usuário é maior de idade' }, status: :unprocessable_entity
      return
    end
  end

  def setar_usuario
    @usuario = Usuario.find(params[:id])
  end

  def permissao_usuario_params
    params.permit(:data_inicio, :data_fim, :descricao_permissao)
  end
end
