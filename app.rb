require "bundler/setup"

require 'sinatra'
require 'typhoeus'

post '/' do
  api_url = "https://buy.itunes.apple.com/verifyReceipt"
  request.body.rewind  # in case someone already read it
  receipt = request.body.read
  external_request = Typhoeus::Request.new(
    api_url,
    method: :post,
    body: receipt
  )
  external_request.run.body
end
