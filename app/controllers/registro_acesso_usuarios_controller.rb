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
    
    filtrar_por_data if params[:created_at].present?
    filtrar_por_prontuario if params[:prontuario].present?
    filtrar_por_cpf if params[:cpf].present?
    
    render :index
  end

  private

  def registrar_acesso_params
    params.permit(:tipo)
  end

  def setar_usuario
    begin
      if params[:prontuario].present?
        @usuario = Usuario.find_by(prontuario: params[:prontuario])
      elsif params[:cpf].present?
        @usuario = Usuario.find_by(cpf: params[:cpf])
      else
        render json: { error: "Prontuário ou CPF não informado" }, status: :bad_request
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :not_found
    end
  end

  def filtrar_por_data
    data = Date.parse(params[:created_at]).to_datetime
    @registro_acesso_usuarios = @registro_acesso_usuarios.where(created_at: data.beginning_of_day..data.end_of_day) 
  end

  def filtrar_por_prontuario
    @registro_acesso_usuarios = @registro_acesso_usuarios.joins(:usuario).where("usuarios.prontuario LIKE ?", "%#{params[:prontuario]}%")
  end

  def filtrar_por_cpf
    @registro_acesso_usuarios = @registro_acesso_usuarios.joins(:usuario).where("usuarios.cpf LIKE ?", "%#{params[:cpf]}%")
  end
end
