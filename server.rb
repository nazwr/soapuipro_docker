require "sinatra/base"

class App < Sinatra::base
    set :bind, "0.0.0.0"

    get "/" do
        "<p>Hello world!</p>"
    end
end