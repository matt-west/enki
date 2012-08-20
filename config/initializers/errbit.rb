Airbrake.configure do |config|
	config.api_key		= 'b63a1721fdef643ff17a25fb17fc1328'
	config.host				= 'dc-error-tracking.herokuapp.com'
	config.port				= 80
	config.secure			= config.port == 443
end