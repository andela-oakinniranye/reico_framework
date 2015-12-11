require './dsl'

class Reico
  include DSL

  PID_FILE = "tmp/pids/server.pid"

  @@token = []

  def initialize(name: nil)
    formulate_name(name) if name
  end

  # def formulate_name(name, req)
  #   case name
  #   when 'squareup'
  #     @@token << req.params
  #     response({data: 'Authenticated'}.to_json)
  #   when 'callback'
  #   when 'checking'
  #     response({data: @@token}.to_json)
  #   end
  # end

  def root_path
    response({data: 'Got root url good'}.to_json)
  end

  def self.call(env)

    route_handler = new
    req = Rack::Request.new env

      routes_and_handler = route_handler.all_routes

      path = req.path
      method_append = path.match(/^[\/]?(.*)[\/]?/)

      method_called = req.request_method.downcase.to_sym

      methods_allowed = routes_and_handler.keys
      defined_method = "#{method_called}_#{$1}"

      if methods_allowed.include?(method_called) && route_handler.respond_to?(defined_method)
        route_handler.send(defined_method)
      else
        route_handler.invalid_route
      end


            # response({data: [1,2, 2]}.to_json)



            # puts req.request_method

            # puts "I was allowed and called"
            # routes_and_handler[method_called].each{}
            # , {amazing: true}.to_json


            #
            # puts "================<><><><><><>=================="
            # puts   defined_method
            #
            # puts "================<><><><><><>=================="


            # routes = routes_and_handler.


            # case req.path
            # when '/'
            #   route_handler.root_path
            # when /^\/(.*)/
            #   route_handler.formulate_name($1, req)
            #   # formulate_name
            # else
            #   route_handler.invalid_route
            #   # RoutingError.new
            # end
  end

  def invalid_route message: 'Invalid URL Specified',status: 404
    Rack::Response.new(message, status)
  end



  def response(doc)
    resp = Rack::Response.new
    resp.write(doc)
    resp['Content-Type'] = 'application/json'
    resp.status = 200
    resp.finish
  end

  def request_params

  end

end
