class ApplicationController < ActionController::API
  def checar_admin
    if current_usuario.admin?
      return true
    else
      render json: { error: 'Não tem permissão para acessar os usuarios do sistema!' }, status: :unauthorized
    end
  end
end
