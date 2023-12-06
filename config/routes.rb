Rails.application.routes.draw do
  devise_for :usuarios, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
  },
  controllers: {
    sessions: 'users/sessions',
  }, skip: [:passwords, :registrations]

  # usuarios
  post '/visitantes', to: 'usuarios#criar_visitante'

  get '/usuarios', to: 'usuarios#listar_usuarios'
  put '/usuarios/:id', to: 'usuarios#atualizar_usuario'

  get '/alunos', to: 'usuarios#listar_alunos'

  # registro_acesso_usuarios
  post '/registro_acesso_usuarios', to: 'registro_acesso_usuarios#registrar_acesso'
  get '/registro_acesso_usuarios', to: 'registro_acesso_usuarios#listar_registros'

  # permissao_usuarios
  post '/usuarios/:id/permissoes_usuario', to: 'permissao_usuarios#criar_permissao'
  get '/usuarios/:id/permissoes_usuario', to: 'permissao_usuarios#listar_permissoes'

  post '/usuarios/importar_csv', to: 'usuarios#importar_usuarios'
end
