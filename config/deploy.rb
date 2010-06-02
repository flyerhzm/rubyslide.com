require 'capistrano/recipes/deploy/scm/base'
require 'capistrano/recipes/deploy/scm/git'
::Capistrano::Deploy::SCM::Base.class_eval do
  alias_method :origin_scm, :scm
  def scm(*args)
    if command == "git" and args[0] == "ls-remote"
      args[0] = "ls-remote --upload-pack=/home1/huangzhi/git/bin/git-upload-pack"
    end
    origin_scm(args)
  end
end
::Capistrano::Deploy::SCM::Git.class_eval do
  def checkout(revision, destination)
    git    = "/home1/huangzhi/git/bin/git"
    remote = origin

    args = []
    args << "-o #{remote}" unless remote == 'origin'
    if depth = configuration[:git_shallow_clone]
      args << "--depth #{depth}"
    end

    execute = []
    if args.empty?
      execute << "#{git} clone --upload-pack=/home1/huangzhi/git/bin/git-upload-pack #{verbose} #{configuration[:repository]} #{destination}"
    else
      execute << "#{git} clone --upload-pack=/home1/huangzhi/git/bin/git-upload-pack #{verbose} #{args.join(' ')} #{configuration[:repository]} #{destination}"
    end

    # checkout into a local branch rather than a detached HEAD
    execute << "cd #{destination} && #{git} checkout #{verbose} -b deploy #{revision}"
    
    if configuration[:git_enable_submodules]
      execute << "#{git} submodule #{verbose} init"
      execute << "#{git} submodule #{verbose} sync"
      execute << "#{git} submodule #{verbose} update"
    end

    execute.join(" && ")
  end
end

set :application, "rubyslide.com"
set :repository,  "huangzhi@huangzhimin.com:gits/rubyslide.git"
set :user, "huangzhi"
set :scm, :git
set :deploy_to, "/home1/huangzhi/sites/rubyslide.com"
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
    run "ln #{shared_path}/.htaccess #{current_release}/public/.htaccess"
    run "cp #{shared_path}/config/environment.rb #{current_release}/config/"
    run "ln #{shared_path}/config/initializers/slideshare.rb #{current_release}/config/initializers/slideshare.rb"
    run "chmod -R u+rwX,go-w #{current_release}/public #{current_release}/log"
  end

  task :restart do
    migrate
    cleanup
    run "#{current_release}/script/process/reaper --action=restart --dispatcher=dispatch.fcgi"
  end
end

