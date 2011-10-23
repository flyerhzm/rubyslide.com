Rubyslide::Application.routes.draw do
  root :to => 'slides#index'
  match '/feed' => 'slides#feed', :as => :feed
  match "/user/:username/slides" => "slides#index", :as => :user_slides
  match '/user/:username/feed' => 'slides#feed', :as => :user_feed
  resources :tags do
    resources :slides
  end
end
