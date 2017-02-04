Rails.application.routes.draw do
  resources :members
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  controller :pages do
    get '/' => :home, as: :home
  end
end
