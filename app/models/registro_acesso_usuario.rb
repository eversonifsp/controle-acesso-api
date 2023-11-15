class RegistroAcessoUsuario < ApplicationRecord
  belongs_to :usuario

  enum tipo: [:entrada, :saida]
end
