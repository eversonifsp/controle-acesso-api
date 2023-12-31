class RegistroAcessoUsuariosController < ApplicationController
  before_action :authenticate_usuario!
  
  before_action :checar_admin, only: [:listar_registros]
  before_action :checar_porteiro, only: [:registrar_acesso]

  before_action :setar_usuario, only: [:registrar_acesso]

  def registrar_acesso
    @registro_acesso_usuario = @usuario.registro_acesso_usuarios.new(registrar_acesso_params)
  
    if @registro_acesso_usuario.save
      render :show, status: :created
    else
      render json: @registro_acesso_usuario.errors, status: :unprocessable_entity
    end
  end

  def listar_registros
    @registro_acesso_usuarios = RegistroAcessoUsuario.all.order(created_at: :desc)
    
    filtrar_por_data if params[:data].present?
    filtrar_por_prontuario_cpf if params[:prontuario_cpf].present?
    
    render :index
  end

  private

  def registrar_acesso_params
    params.permit(:tipo)
  end

  def setar_usuario
    begin
      if params[:prontuario_cpf].present?
        @usuario = Usuario.where('prontuario = ? OR cpf = ?', params[:prontuario_cpf], params[:prontuario_cpf]).first
        @usuario.present? ? @usuario : raise(ActiveRecord::RecordNotFound.new("Usuário não encontrado"))
      else
        render json: { error: "Prontuário ou CPF não informado" }, status: :bad_request
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :not_found
    end
  end

  def filtrar_por_data
    data = Date.parse(params[:data]).to_datetime
    @registro_acesso_usuarios = @registro_acesso_usuarios.where(created_at: data.beginning_of_day..data.end_of_day) 
  end

  def filtrar_por_prontuario_cpf
    @registro_acesso_usuarios = @registro_acesso_usuarios.joins(:usuario).where("usuarios.prontuario LIKE ? OR usuarios.cpf LIKE ?", "%#{params[:prontuario_cpf]}%", "%#{params[:prontuario_cpf]}%")
  end
end
