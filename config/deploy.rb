set :user, 'root'
set :domain, '46.32.255.234'
set :application, 'Coding Skyscrapers'

default_run_options[:pty] = true

# default_environment['PATH']='/usr/local/rvm/gems/ruby-1.9.2-p290/bin:/usr/local/rvm/gems/ruby-1.9.2-p290@global/bin:/usr/local/rvm/rubies/ruby-1.9.2-p290/bin:/usr/local/rvm/bin::/root/bin:/bin:/usr/bin:/usr/sbin:/usr/local/bin'

# Add RVM's lib directory to the load path.
#$:.unshift(File.expand_path('./lib', ENV['rvm_path']))

# Load RVM's capistrano plugin.    
require "rvm/capistrano"
require "airbrake/capistrano"

set :rvm_ruby_string, '1.9.2-p320@enki'
set :rvm_type, :system
set :rvm_path, '/usr/local/rvm'

set :repository, "git@github.com:matt-west/enki.git"
set :deploy_to, "/var/www/vhosts/cs"

role :app, domain
role :web, domain
role :db, domain, :primary => true

set :deploy_via, :remote_cache
set :scm, :git
set :branch, 'master'
set :scm_verbose, true
set :use_sudo, false
set :keep_releases, 5

namespace :deploy do
	desc "cause Passenger to initate restart"
	task :restart do
		# Make sure that the tmp directory is writable
		run "chmod 777 -R #{current_path}/tmp"
		# Restart the App Server
		run "touch #{current_path}/tmp/restart.txt"
	end

	desc "reload the database with seed data"
	task :seed do
		run "cd #{current_path}; rake db:seed RAILS_ENV=production"
	end

	desc "Updates the symlink for config files to the just deployed release."
  task :symlink_configs do
  	run "cp -f #{shared_path}/config/production.rb #{release_path}/config/environments/production.rb"
  	run "cp -f #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    # run "ln -nfs #{shared_path}/config/newrelic.yml #{release_path}/config/newrelic.yml"
    # run "cp -f #{shared_path}/config/omniauth.rb #{release_path}/config/initializers/omniauth.rb"
  end
end

after "deploy:update_code", "deploy:symlink_configs", :bundle_install
desc "install the necessary prerequisites"
task :bundle_install, :roles => :app do
	run "cd #{release_path} && bundle install --path vendor/cache"
end


# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end