# Reico Server

## Inspiration
I've been using the Sinatra framework, as well as the Ruby on Rails framework for a while but I've always loved the way someone or a group of
people come together to build something which ends up making our lives easier.

I was most fascinated by Sinatra which was built with less than 3000 lines of code with very little baggage and I kept telling myself that if someone else could do it, so can I.

`Currently, its been configured to only respond with a content type of 'application/json'`

To define your routes, all you have to do is:

```ruby
  require './dsl'

  class Reico
    include DSL

    def root_path
      response({data: :amazing}.to_json)
    end
  end

  Reico.serve do
    get '/path', to: "controller#action"

    get '/path2' do
      #evaluate path2 here
    end
  end
```

In you `config.ru` you may want to run, depending on the class you are serving from. Mine is from `Reico`

```ruby
  Rack::Handler::WEBrick.run Reico
```

There are a lot of implementations that has not been done in this, including security, error handling, testing amongst others, but as they say `Great things starts small`
