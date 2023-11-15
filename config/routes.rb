Rails.application.routes.draw do
  devise_for :usuarios, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # usuarios
  get '/usuarios', to: 'usuarios#listar_usuarios'
  put '/usuarios/:id', to: 'usuarios#atualizar_usuario'

  # registro_acesso_usuarios

  get '/registro_acesso_usuarios', to: 'registro_acesso_usuarios#listar_registros'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
