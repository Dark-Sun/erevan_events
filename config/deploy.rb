# config valid only for Capistrano 3.1
lock '3.4'

set :application, 'erevan_events'
set :repo_url, 'git@github.com:Dark-Sun/erevan_events.git'

# Default branch is :master
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/var/www/erevan_events'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml config/sidekiq.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/assets}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

set :bundle_binstubs, nil

# Default value for keep_releases is 5
set :keep_releases, 5

set :tmp_dir, "/home/deploy/tmp"

Capistrano::Env.use do |env|
  env.add 'PATH', '/home/deploy/.rvm/gems/ruby-2.1.1/bin:/home/deploy/.rvm/rubies/ruby-2.1.1/bin:/home/deploy/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/user/.rvm/bin'
  env.add 'RAILS_ENV', fetch(:rails_env)
  env.formatter = :dotenv
end

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
