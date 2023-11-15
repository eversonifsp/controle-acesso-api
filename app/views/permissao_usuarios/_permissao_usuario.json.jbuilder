json.extract! permissao_usuario, :id, :data_inicio, :data_fim, :descricao_permissao, :created_at, :updated_at

json.aluno do
  json.extract! permissao_usuario.usuario, :id, :nome, :cpf, :prontuario, :tipo, :created_at, :updated_at
end
