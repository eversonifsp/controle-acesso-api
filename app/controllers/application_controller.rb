class ApplicationController < ActionController::API
  def checar_admin
    if current_usuario.admin?
      return true
    else
      render json: { error: 'Não tem permissão para acessar os usuarios do sistema!' }, status: :unauthorized
    end
  end

  def checar_secretario
    if current_usuario.admin? || current_usuario.secretario?
      return true
    else
      render json: { error: 'Não tem permissão para acessar os usuarios do sistema!' }, status: :unauthorized
    end
  end

  def checar_porteiro
    if current_usuario.admin? || current_usuario.porteiro?
      return true
    else
      render json: { error: 'Não tem permissão para acessar os usuarios do sistema!' }, status: :unauthorized
    end
  end
end
