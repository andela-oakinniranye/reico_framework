require 'rack'
require 'json'
require 'pry'
require './serv'

app = Proc.new{ |env|
  [200, {'Content-Type' => 'application/json'}, [{mail: 'application'}.to_json]]
}

class RoutingError < NameError
  def initialize
    super('Invalid Route Specified')
  end
end

Reico.serve do
  # get '/', '/game', '/amazing' do

  # end
  get '/', to: 'oreoluwa#action'

  get '/cent', to: 'cent#whatever'

  # get '/kay', to: 'kay#coolio'

  # get '/daisi', to: 'daisi#yes'

  post '/', to: 'class#method'

  post '/this_is_cool'

  # '/cool', '/great',

  all_routes

 #  do
 #
 # end
end




#
# get '/route' do
#
# end

# trap('INT') do
#   puts "Gracefully shutting down the server"
#   # "kill -9 #{}"
#   process_id = `cat #{Reico::PID_FILE}`
#   `kill -9 #{process_id}`
#   exit
#   # system()
# end


Rack::Handler::WEBrick.run Reico
