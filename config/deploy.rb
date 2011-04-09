set :application, "rubyslide.com"
set :repository,  "git@github.com:flyerhzm/rubyslide.com.git"
set :user, "huangzhi"
set :scm, :git
set :deploy_to, "/home/huangzhi/sites/rubyslide.com/production"
set :deploy_via, :remote_cache
set :rails_env, :production

role :app, "rubyslide.com"
role :web, "rubyslide.com"
role :db,  "rubyslide.com", :primary => true

after "deploy:update_code", "config:init"

namespace :config do
  task :init do
    run "ln -s #{shared_path}/config/database.yml #{current_release}/config/database.yml"
    run "cp #{shared_path}/config/environment.rb #{current_release}/config/"
    run "ln #{shared_path}/config/initializers/slideshare.rb #{current_release}/config/initializers/slideshare.rb"
    run "chmod -R u+rwX,go-w #{current_release}/public #{current_release}/log"
  end
end

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    migrate
    cleanup
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

