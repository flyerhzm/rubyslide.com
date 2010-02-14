set :application, "rubyslide.com"
set :repository,  "huangzhi@huangzhimin.com:gits/rubyslide.git"
set :user, "jill"
set :scm, :git
set :deploy_to, "/home/jill/sites/rubyslide.com"
set :deploy_via, :export
set(:releases) { capture("ls -x #{releases_path}").split }

role :app, "gmhxpgaa.cust.joyent.com.cn"
role :web, "gmhxpgaa.cust.joyent.com.cn"

set :use_sudo, false
set :run_method, :run

namespace(:deploy) do
  task :after_update_code, :roles => :app do
    run "ln -s #{shared_path}/config/database.yml #{current_release}/config/database.yml"
    run "cp #{shared_path}/.htaccess #{current_release}/public/"
    run "cp #{shared_path}/config/environment.rb #{current_release}/config/"
    run "chmod -R u+rwX,go-w #{current_release}/public #{current_release}/log"
  end

  task :restart do
    cleanup
  end
end

