require 'sinatra'
require 'json'

get '/' do
  content_type :json

  message = "Hello test"
  result = {
    status: 200,
    result: {
      branch: "test",
      message: message
    }
  }

  result.to_json
end
