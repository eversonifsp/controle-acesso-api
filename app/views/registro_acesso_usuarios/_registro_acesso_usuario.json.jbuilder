json.extract! registro_acesso_usuario, :id, :tipo, :created_at, :updated_at

json.usuario do
  json.extract! registro_acesso_usuario.usuario, :id, :nome, :cpf, :prontuario
end
