Rails.application.routes.draw do
  resources :members

  resources :pages do
    collection do
      get :navigate_slack
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  controller :posts do
    get '/blog' => :index, as: :blog
    get '/blog/:name' => :show, as: :post
  end

  controller :pages do
    get '/' => :home, as: :home
    get '/about' => :about, as: :about
    get '/interest_groups' => :interest_groups, as: :interest_groups
    get '/calendar' => :calendar, as: :calendar
  end
end
