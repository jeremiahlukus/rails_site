require 'google/sapis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'

require 'fileutils'

OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
APPLICATION_NAME = 'PantherHackers rails_site'
CLIENT_SECRETS_PATH = 'client_secret.json'
CREDENTIALS_PATH = File.join(Dir.home, '.credentials', "calendar-ruby-quickstart.yaml")
SCOPE = Google::Apis::CalendarV3::AUTH_CALENDAR_READONLY


class Event

  attr_reader :name, :start_datetime, :end_datetime, :description, :location, :link

	def initialize(event_json)
	  @name = event_json.name
		@start_datetime = event_json.start
		@end_datetime = event_json.end
		@location = event_json.location
		@description = event_json.description
		@link = event_json.description.split.first
	end

	def authorize
	  FileUtils.mkdir_p(File.dirname(CREDENTIALS_PATH))

	  client_id = Google::Auth::ClientId.from_file(CLIENT_SECRETS_PATH)
	  token_store = Google::Auth::Stores::FileTokenStore.new(file: CREDENTIALS_PATH)
	  authorizer = Google::Auth::UserAuthorizer.new(
	    client_id, SCOPE, token_store)
	  user_id = 'default'
	  credentials = authorizer.get_credentials(user_id)
	  if credentials.nil?
	    url = authorizer.get_authorization_url(
	      base_url: OOB_URI)
	    puts "Open the following URL in the browser and enter the " +
	         "resulting code after authorization"
	    puts url
	    code = gets
	    credentials = authorizer.get_and_store_credentials_from_code(
	      user_id: user_id, code: code, base_url: OOB_URI)
	  end
	  credentials
	end

  def self.pull_calendar_data
  	# Initialize the API
		service = Google::Apis::CalendarV3::CalendarService.new
		service.client_options.application_name = APPLICATION_NAME
		service.authorization = authorize
  
		# Fetch the next 10 events for the user
		calendar_id = 'primary'
		response = service.list_events(calendar_id,
		                               single_events: false,
		                               order_by: 'startTime',
		                               time_min: Time.now - 1.month, 
		                               time_max: Time.now + 1.month)

		puts "Upcoming events:"
		puts "No upcoming events found" if response.items.empty?
		event_array = Array.new
		response.items.each do |event|
			  event_array.push(Event.new(event))
		end
		event_array
	end
end
	







