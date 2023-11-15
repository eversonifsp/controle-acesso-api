class UsuariosController < ApplicationController
  before_action :authenticate_usuario!

  before_action :checar_admin, only: [:atualizar_usuario, :listar_usuarios]
  before_action :checar_secretario, only: [:listar_alunos]

  before_action :setar_usuario, only: [:atualizar_usuario]

  def listar_usuarios
    @usuarios = Usuario.all
    render :index
  end

  def listar_alunos
    @usuarios = Usuario.where(tipo: 'aluno')
    filtrar_por_prontuario if params[:prontuario].present?
    
    render :index
  end

  def atualizar_usuario
    if @usuario.update(params_usuario)
      render :show
    else
      render json: { error: 'Não foi possível atualizar o usuário!' }, status: :unprocessable_entity
    end
  end

  private

  def filtrar_por_prontuario
    @usuarios = @usuarios.where("prontuario LIKE ?", "%#{params[:prontuario]}%")
  end

  def setar_usuario
    @usuario = Usuario.find(params[:id])
  end

  def params_usuario
    params.permit(:tipo)
  end
end
