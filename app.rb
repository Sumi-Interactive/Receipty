require "bundler/setup"

require "base64"
require 'sinatra'
require 'typhoeus'

post '/' do
  request.body.rewind  # in case someone already read it
  receipt = Base64.encode64(request.body.read)
  request = Typhoeus::Request.new(
    "https://buy.itunes.apple.com/verifyReceipt",
    method: :post,
    params: { "receipt-data" => receipt }
  )
  request.run.body
end
