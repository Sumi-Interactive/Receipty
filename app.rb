require "bundler/setup"

require 'sinatra'
require 'typhoeus'

post '/' do
  request.body.rewind  # in case someone already read it
  receipt = request.body.read
  external_request = Typhoeus::Request.new(
    "https://sandbox.itunes.apple.com/verifyReceipt",
    method: :post,
    body: receipt
  )
  external_request.run.body
end
