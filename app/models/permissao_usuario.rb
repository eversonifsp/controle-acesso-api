class PermissaoUsuario < ApplicationRecord
  belongs_to :usuario

  has_one_attached :foto_documento
end
