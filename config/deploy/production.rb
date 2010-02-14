set :application, "rubyslide.com"
set :repository,  "huangzhi@huangzhimin.com:gits/rubyslide.git"
set :user, "huangzhi"
set :scm, :git
set :deploy_to, "/home7/huangzhi/sites/rubyslide.com"
set :deploy_via, :export
set(:releases) { capture("ls -x #{releases_path}").split }

role :app, "rubyslide.com"
role :web, "rubyslide.com"
role :db,  "rubyslide.com", :primary => true

set :use_sudo, false
set :run_method, :run

namespace(:deploy) do
  task :after_update_code, :roles => :app do
    run "ln -s #{shared_path}/config/database.yml #{current_release}/config/database.yml"
    run "cp #{shared_path}/.htaccess #{current_release}/public/"
    run "cp #{shared_path}/config/environment.rb #{current_release}/config/"
    run "cp #{shared_path}/config/initializers/slideshare.rb #{current_release}/config/initializers/"
    run "chmod -R u+rwX,go-w #{current_release}/public #{current_release}/log"
  end

  task :restart do
    migrate
    sitemap
    cleanup
    run "#{current_release}/script/process/reaper --action=restart --dispatcher=dispatch.fcgi"
  end
end

