require_relative './app.rb'

Miira.run!(host: '0.0.0.0')

fork do
  exec("bundle exec ruboty")
end
