class Event

  attr_reader :name, :start, :end, :description, :location, :link, :thumbnail

	def initialize(sum, start_dt, end_dt, loc, desc, link, thumb)
	  @name = sum
	  @start = start_dt
	  @end = end_dt
	  @location = loc
	  @description = desc
	  @link = link
	  @thumbnail = thumb
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

    event_array = response['items'].map { |event| 
    		 				if event['status'] != "cancelled"
    		 					begin
    								#Continue if date is in dateTime format
      		 					Event.new(event['summary'], 
      		 					DateTime.iso8601(event.dig('start','dateTime')), 
      		 					DateTime.iso8601(event.dig('end','dateTime')), 
      		 					event['location'], 
      		 					event['description'], 
      		 					event['description'].to_s.split.first, 
      		 					event['description'].to_s.split.second)
      		 				rescue
      		 					#If not, then get dateTime
      		 					#from date yyyy-mm-dd format
      		 					Event.new(event['summary'], 
      		 					DateTime.iso8601(event.dig('start', 'date')), 
      		 					DateTime.iso8601(event.dig('end', 'date')), 
      		 					event['location'], 
      		 					event['description'], 
      		 					event['description'].to_s.split.first, 
      		 					event['description'].to_s.split.second)
      		 				end
    		 				end
}
	  event_array
	end
end
	







