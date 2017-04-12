namespace :events do

  desc "Pulls events from PH Google Calendar and stores them in our AWS database"
  task import: :environment do    
  	PARAMS = { query: { key: ENV['GOOGLE_API_KEY'], 
               calendarId: 'PantherHackers@gmail.com', 
               timeMin: (Time.now - 1.month).iso8601, 
               timeMax: (Time.now + 1.month).iso8601 }
    	}.freeze
    CALENDAR_API_URL = 'https://www.googleapis.com/calendar/v3/calendars/calendarId/events'.freeze

    response = HTTParty.get(CALENDAR_API_URL, PARAMS)
   	
    response['items'].reject{|item| item['status'] == "cancelled"}.map{ |event| 
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
      }
   end
end