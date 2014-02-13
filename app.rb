require 'rubygems'; require 'bundler'; Bundler.require

require 'ruby-debug'
require 'faraday'

dir = File.expand_path('..', __FILE__)
require dir + '/config'

get '/' do
	erb :index
end

get '/step1' do
	@client = OAuth2::Client.new(CLIENT_ID, CLIENT_SECRET, :site => PROVIDER_SITE, :authorize_url => AUTHORIZE_URL, :token_url => TOKEN_URL, :connection_opts => { :scope => "test" })
	redirect @client.auth_code.authorize_url
end

get '/step2' do
	@code = params[:code]

	# Used when you need to look at the details of the response for debugging
	# conn = Faraday.new(:url => PROVIDER_SITE) do |faraday|
	#   faraday.request  :url_encoded             # form-encode POST params
	#   faraday.response :logger                  # log requests to STDOUT
	#   faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
	# end

	# response = conn.post TOKEN_URL, { :code => @code, :client_id => CLIENT_ID, :client_secret => CLIENT_SECRET}

	# debugger

	# Rack::Utils.parse_query(response.body)

	@client = OAuth2::Client.new(CLIENT_ID, CLIENT_SECRET, :site => PROVIDER_SITE, :authorize_url => AUTHORIZE_URL, :token_url => TOKEN_URL)

	erb "<p>temporary code: <%= @code %></p><p>Token: <%= @token.token %></p>"
end