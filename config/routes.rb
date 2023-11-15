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

  get '/users', to: 'usuarios#list_users'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
