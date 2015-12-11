module DSL
  def self.included(base)
    # base.send :include, InstanceMethods
    base.extend ClassMethods
  end

  module ClassMethods
    def serve(&block)
      method_to_call = new
      method_to_call.instance_eval(&block)
    end


    def router_reg(route_param, method_called)
      path = route_param[:path]
      action_defined = route_param[:use]

      path_defined = path.match(/^[\/]?(.*)[\/]?/)
      action = "#{method_called}_#{$1}"

      define_method action do #|arg|
        if action_defined
          resp = action_to_call(action_defined)
          response(resp)
        elsif action == 'get_' || action == 'post_'
          root_path
        else
          invalid_route(message: "Invalid Router Configuration. Don't know how to formulate the called route", status: 500)
        end
      end
      # action = method_called.to_s +

        # response(arg)
        # puts "I was called and it was awesome"
      # require 'pry' ; binding.pry
    end
  end

  def action_to_call(route_param_use)
    controller_and_action = route_param_use.split('#')
    controller = controller_and_action[0].capitalize
    action = controller_and_action[1]
    controller = eval(controller).new
    controller.send(action)
  end

  def register_routes(method, route_params)
    @@methods_and_routes ||= {}
    @@methods_and_routes[method] ||= []
    @@methods_and_routes[method] << route_params
  end

  def method_missing(method_name, *args, &block)
    analyze_method(method_name, args, &block)
  end

  def all_routes
    @@methods_and_routes
  end

  def analyze_method(method_name, *args, &_block)
    # puts method_name
    if [:get, :post].include? method_name
      args = manipulate(args)

      self.class.router_reg(args, method_name)

      register_routes(method_name, args)
      all_routes
    else
      puts 'I was here'
    end
  end

  def manipulate(_args)
    route = {}
    _args.flatten.each do |_arg|
      if _arg.is_a? String
        route[:path] = _arg
      elsif _arg.is_a? Hash
        _arg.each do |_key, _val|
          if _key == :to
            route[:use] = _val
          elsif _key == :as
            route[:alias] = _val
          end
        end
      else
        # puts "This happened"
      end
    end
    route
  end
end

class Oreoluwa
  def action
    # 'Oreoluwa is awesome'
    {kool: :right, awesome: :amazing}.to_json
  end
end


class Cent
  def whatever
    {president: :amity, awesome: :cool}.to_json
  end
end

class Kay
  def coolio
    {jumper: :yeah, kay: :kode}.to_json
  end
end

class Daisi
  def yes
    {this: :is, it: :yes}.to_json
  end
end


    # routes.each do |route|
    # end

        #   route[arg]
        # route
        # puts 'This is cool'
# puts route
# @@methods_and_routes[method].flatten

# def get(*args, &block)
#   # register_routes()
#   puts "I called get"
# end
#
# def post(*args, &block)
#   puts args
# end
# puts args
# send(:register_routes, args, &block)
# end
