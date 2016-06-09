require 'httparty'

module Wopinator
  class HTTPClient
    include HTTParty
    headers 'User-Agent' => 'WOPInator Discover Client'
  end
end
