Rails.application.routes.draw do

  resources :roles

  resources :items do
    collection do 
      get :autocomplete
    end
  end
   
  root "items#index"
end
