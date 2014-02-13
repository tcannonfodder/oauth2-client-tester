# require 'rubygems'; require 'bundler'; Bundler.require

require 'ruby-debug'

dir = File.expand_path('..', __FILE__)
require dir + '/config'

require 'faraday'

conn = Faraday.new(:url => PROVIDER_SITE) do |faraday|
  faraday.request  :url_encoded             # form-encode POST params
  faraday.response :logger                  # log requests to STDOUT
  faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
end

CODE = 'qz5x1n4g7xepe4skhbzf0i5omlbjp2p'

response = conn.post TOKEN_URL, { :code => CODE, :client_id => CLIENT_ID, :client_secret => CLIENT_SECRET}

debugger


puts response

