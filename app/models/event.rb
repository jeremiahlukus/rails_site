class Event

  attr_reader :name, :start_datetime, :end_datetime, :description, :location, :link, :thumbnail

	def initialize(event_json)
	  @name = event_json['summary']
	  @start_datetime = event_json['start']
	  @end_datetime = event_json['end']
	  @location = event_json['location']
	  @description = event_json['description']
	  @link = (event_json['description'].to_s).split.first
	  @thumbnail = (event_json['description'].to_s).split.second
	end

  def self.pull_calendar_data

  	#Establish base uri for Google Calendar API
	  uri = URI('https://www.googleapis.com/calendar/v3/calendars/calendarId/events')

	  #Create dynamic parameters for the API call
	  #Check Google Calendar.List API Documentation for more params
   	  params = {:key => ENV['GOOGLE_API_KEY'], 
   	  			  # :maxResults => 1,
				  :calendarId => 'PantherHackers@gmail.com', 
				  :timeMin => (Time.now - 1.month).iso8601, 
				  :timeMax => (Time.now + 1.month).iso8601}

		#Combine params and URI
	  uri.query = URI.encode_www_form(params)

		#Make the HTTP request
	  response = JSON.parse(Net::HTTP.get(uri))
	  event_array = Array.new
	  response['items'].each do |event|
	  	puts event
	    event_array.push(Event.new(event))
	  end
	  event_array
	end
end
	







