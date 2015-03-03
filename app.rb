require 'sinatra'
require 'json'

get '/' do
  content_type :json

  message = "Hello fuga"
  result = {
    status: 200,
    result: {
      branch: "fuga",
      message: message
    }
  }

  result.to_json
end
