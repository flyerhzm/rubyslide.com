set :application, "rubyslide.com"
set :repository,  "git@github.com:flyerhzm/rubyslide.com.git"
set :user, "huangzhi"
set :scm, :git
set :deploy_to, "/home/huangzhi/sites/rubyslide.com/production"
set :deploy_via, :remote_cache
set :rails_env, :production
set :use_sudo, false

require 'bundler/capistrano'

$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require 'rvm/capistrano'
set :rvm_ruby_string, 'ruby-1.9.2-p290@rubyslide.com'
set :rvm_type, :user

set :whenever_command, "bundle exec whenever"
require "whenever/capistrano"

role :web, "rubyslide.com"
role :app, "rubyslide.com"
role :db,  "rubyslide.com", :primary => true

after "deploy:update_code", "config:init"

namespace :config do
  task :init do
    run "ln -nfs #{shared_path}/config/database.yml #{current_release}/config/database.yml"
    run "ln -nfs #{shared_path}/config/initializers/slideshare.rb #{current_release}/config/initializers/slideshare.rb"
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

