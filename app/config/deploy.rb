set :application, "wayci"
set :domain,      "69.195.198.111"
set :deploy_to,   "/var/www/vhosts/mbcomunicacionessac.com/symfony_projects/"
set :app_path,    "app"

set :user,		  "mb"	
set :use_sudo,      false
ssh_options[:port] = 22123
#set :php_bin,		"usr/bin/php" 

set :repository,  "https://github.com/mloyola/quierocomprar.git"
set :scm,         :git
set :branch,        "master"
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `subversion`, `mercurial`, `perforce`, or `none`

set :model_manager, "doctrine"
# Or: `propel`

role :web,        domain                         # Your HTTP server, Apache/etc
role :app,        domain, :primary => true       # This may be the same as your `Web` server
#role :db,         domain, :primary => true       # This may be the same as your `Web` server

set  :keep_releases,  3

set :shared_files,        ["app/config/parameters.yml"]
set :shared_children,     [app_path + "/logs", web_path + "/uploads", "vendor"]

set :writable_dirs,       ["app/cache", "app/logs"]
set :webserver_user,      "www-data"
set :permission_method,   :acl
set :use_set_permissions, true

after "deploy:update_code" do
  capifony_pretty_print "--> Fixing permissions"
  run "cd #{latest_release} && find . -type f -exec chmod 644 {} \\"
  run "cd #{latest_release} && find . -type d -exec chmod 755 {} \\"
  capifony_puts_ok
end
# Be more verbose by uncommenting the following line
# logger.level = Logger::MAX_LEVEL