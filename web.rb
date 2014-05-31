require 'rubygems'
require 'twilio-ruby'
require 'sinatra'
 
get '/' do
    'Hello World! Currently running version ' + Twilio::VERSION + \
        ' of the twilio-ruby library.'
end

get '/hello-twilio' do
	content_type 'text/xml'

	Twilio::TwiML::Response.new do |r|
		r.Say 'Floozy Flub Buddies'
	end.text
end
