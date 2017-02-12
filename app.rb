require 'sinatra/base'

class Miira < Sinatra::Base
  get '/' do
    "Hello, world"
  end
end
