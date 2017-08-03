Rails.application.routes.draw do
  resources :members
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  controller :posts do
    get '/blog' => :index, as: :blog
    get '/blog/:name' => :show, as: :post
  end

  controller :pages do
    get '/' => :home, as: :home
    get '/about' => :about, as: :about
    get '/calendar' => :calendar, as: :calendar
    get '/events' => :events, as: :events
  end
end
