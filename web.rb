require 'rubygems'
require 'twilio-ruby'
require 'sinatra'
 
get '/' do
	content_type 'text/xml'

	Twilio::TwiML::Response.new do |r|
		r.Say "Welcome to Acadiana Open Channel."
		r.Say "This is a community provided service used to gather stories from those around Acadiana."
		r.Say "If you haven't already, please visit our website at www.floozy.com to start your conversation."
		r.Gather :numDigits => '6', :action => '/gather', :method => 'get' do |g|
			g.Say 'Please enter your 6 digit code presented on our website.'
		end
	end.text
end

get '/gather' do
	content_type 'text/xml'
	recognized = true
	if recognized
		Twilio::TwiML::Response.new do |r|
			r.Say "Thanks. We recognize this location."
			r.Say "Please leave your message after the tone."
			r.Record :maxLength => '120', :action => '/record', :method => 'get'
		end.text
	else
		Twilio::TwiML::Response.new do |r|
			r.Say "We did not recognize this number.  Please try again."
			r.Gather :numDigits => '6', :action => '/gather', :method => 'get' do |g|
				g.Say 'Please enter your 6 digit code presented on our website.'
			end
		end.text
	end
end

get '/record' do
	content_type 'text/xml'

	Twilio::TwiML::Response.new do |r|
		r.Say "Thanks for your recording."
		r.Say "This is what you said."
		r.Play params['RecordingUrl']
		r.Say "Thanks again for your contribution.  Please have a nice day."
	end.text
end
