# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.

# server '146.185.168.46', user: 'deploy', roles: %w{web app db}
server '46.101.165.209', user: 'root', roles: %w{web app db}

set :rails_env, 'production'

Capistrano::Env.use do |env|
  env.add 'RAILS_ENV', 'production'
  env.formatter = :dotenv
end
