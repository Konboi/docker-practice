require 'sinatra'
require 'json'

get '/' do
  content_type :json

  message = "Hello master"
  result = {
    status: 200,
    result: {
      branch: "master",
      message: message
    }
  }

  result.to_json
end
