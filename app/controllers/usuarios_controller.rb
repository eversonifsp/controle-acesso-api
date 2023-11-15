class UsuariosController < ApplicationController
  before_action :authenticate_usuario!
  before_action :checar_admin
  
  def list_users
    @usuarios = Usuario.all
    render :index
  end
end
