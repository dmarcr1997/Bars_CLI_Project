class EventCog::API
    def fetch
        key  = "Dsx3B7yXadkKedSMijHAO6G4U64oQBkG"
        url = "https://app.ticketmaster.com/discovery/v2/events.json?countryCode=US&apikey=#{key}"
        response = HTTParty.get(url)
        response.parsed_response
        @event_info = []
        response["_embedded"]["events"].each do |event|
           @event_info << {"name" => event["name"],
            "date" => event["dates"]["start"]["localDate"],
           "url" => event["url"], 
           "venue" => event["_embedded"]["venues"][0]["name"], 
            "location" => "#{event["_embedded"]["venues"][0]["address"]["line1"]}, #{event["_embedded"]["venues"][0]["state"]["stateCode"]}"}
        end 
        @event_info
    end
end