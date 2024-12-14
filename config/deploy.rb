# config valid for current version and patch releases of Capistrano
lock '~> 3.19.2'

set :application, 'telegram_sends'
set :repo_url, 'git@github.com:kortirso/telegram_sends.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/var/www/html/telegram_sends'
set :deploy_user, 'deploy'

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, '.env'

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "vendor", "storage"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 2

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

namespace :script do
  desc 'Yarn'
  task :run do
    on roles(:app) do
      within release_path do
        execute 'source /var/www/html/telegram_sends/project_env/bin/activate'
        execute 'pip install -r requirements.txt'
        execute 'python ./script.py'
        execute 'deactivate'
      end
    end
  end
end

after 'deploy:published', 'script:run'
