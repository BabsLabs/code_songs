Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"

  get '/auth/github', as: 'github_connect'
  get '/auth/github/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#failure'

  get '/repos', to: 'repos#index'
  get '/repos_search', to: 'repos/search#index', as: 'repos_search'

  get '/artists', to: 'artists#index'

  patch '/choose_repo', to: 'sessions#update'
  delete '/logout', to: 'sessions#destroy'
end
