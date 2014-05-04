require "bundler/setup"

require 'sinatra'
require 'typhoeus'

post '/' do
  app_env = request.env['HTTP_X_SANDBOX'] ? 'sandbox' : 'buy'

  api_url = "https://#{app_env}.itunes.apple.com/verifyReceipt"

  request.body.rewind  # in case someone already read it
  receipt = request.body.read
  external_request = Typhoeus::Request.new(
    api_url,
    method: :post,
    body: receipt
  )
  external_request.run.body
end
