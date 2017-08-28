require 'httparty'
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
               calendarId: 'briancabigon@gmail.com', 
               timeMin: (Time.now - 1.month).iso8601, 
               timeMax: (Time.now + 1.month).iso8601 }
    }

    response = HTTParty.get('https://www.googleapis.com/calendar/v3/calendars/calendarId/events', params)
    puts response
    response['items'].reject{|item| item['status'] == "cancelled"}.map{ |event| 
                  event_summary = event['summary']
                  event_start_dt = nil
                  event_end_dt = nil
                  event_loc = event['location']
                  event_desc = nil
                  event_sign_up_link = nil
                  event_thumbnail = nil

                  # Rescue for GCalendar date formatting
                  begin
                    event_start_dt = DateTime.iso8601(event.dig('start', 'dateTime'))
                    event_end_dt = DateTime.iso8601(event.dig('end', 'dateTime'))
                  rescue
                    event_start_dt = DateTime.iso8601(event.dig('start', 'date'))
                    event_end_dt = DateTime.iso8601(event.dig('end', 'date'))
                  end

                  # Rescue for GCalendar description 

                  # PHEveCom was asked to put the description in this format for ease of parsing
                  # event_sign_up_link event_thumbnail event_desc
                  # where event_desc = every word after the first two links
                  begin
                    event_desc = event['description'].to_s.split[2..-1].join(' ')
                    event_sign_up_link = event['description'].to_s.split.first
                    event_thumbnail = event['description'].to_s.split.second
                  rescue
                    event_desc = event['description'].to_s
                  end

                   Event.new(event_summary, event_start_dt, event_end_dt, event_loc, 
                      event_desc, event_sign_up_link, event_thumbnail)
    }
  end
end
  







