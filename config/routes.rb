ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'slides', :action => 'index'
  map.feed '/feed', :controller => 'slides', :action => 'feed'
  map.user_slides '/user/:username/slides', :controller => 'slides', :action => 'index'

  map.resources :tags do |tag|
    tag.resources :slides
  end
end
