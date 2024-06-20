Rails.application.routes.draw do
  resources :dramas do
    post 'add_drama', on: :collection
  end
  
  get 'about', to: 'pages#about'
  root "pages#home"
  get 'search', to: 'dramas#search_tmdb', as: 'search_tmdb'

  get 'dramas/year/:year', to: 'dramas#by_year', as: 'dramas_by_year'
end
