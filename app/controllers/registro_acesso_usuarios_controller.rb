class RegistroAcessoUsuariosController < ApplicationController
  before_action :authenticate_usuario!
  before_action :checar_admin

  def listar_registros
    @registro_acesso_usuarios = RegistroAcessoUsuario.all.order(created_at: :desc)
    
    filtrar_por_data if params[:created_at].present?
    filtrar_por_prontuario if params[:prontuario].present?
    filtrar_por_cpf if params[:cpf].present?
    
    render :index
  end

  

  private

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
