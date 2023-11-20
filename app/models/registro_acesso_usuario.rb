class RegistroAcessoUsuario < ApplicationRecord
  belongs_to :usuario

  enum tipo: [:entrada, :saida]
  validate :checar_usuario_permissao

  def checar_usuario_permissao
    if !self.usuario.autorizado? && self.tipo == 'saida'
      errors.add(:usuario, 'Usuário não está autorizado')
    end
  end
end
