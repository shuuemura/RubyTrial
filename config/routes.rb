Rails.application.routes.draw do
  get '/' => "home#index"
  post '/check' => "home#check"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount API::Root => '/'
end
