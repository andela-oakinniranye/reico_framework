require './dsl'

class Reico
  include DSL

  PID_FILE = "tmp/pids/server.pid"

  # @@token = []

  def root_path
    response({data: 'Got root url good'}.to_json)
  end


  def request_params

  end

end

class Oreoluwa
  def action
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
