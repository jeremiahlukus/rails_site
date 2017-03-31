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

  def self.all
    #Create dynamic parameters for the API call
    #See Google Calendar.List API Documentation for more parameters
    params = { query: { key: ENV['GOOGLE_API_KEY'], 
               calendarId: 'PantherHackers@gmail.com', 
               timeMin: (Time.now - 1.month).iso8601, 
               timeMax: (Time.now + 1.month).iso8601 }
    }

    response = HTTParty.get('https://www.googleapis.com/calendar/v3/calendars/calendarId/events', params)

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
  







