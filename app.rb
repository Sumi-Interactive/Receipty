require "bundler/setup"

require 'sinatra'
require 'typhoeus'

post '/' do
  request.body.rewind  # in case someone already read it
  request = Typhoeus::Request.new(
    "https://buy.itunes.apple.com/verifyReceipt",
    method: :post,
    params: { "receipt-data" => request.body.read }
  )
  request.run.body
end
