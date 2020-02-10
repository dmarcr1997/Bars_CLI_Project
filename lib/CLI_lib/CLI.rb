class EventCog::CLI
    @@on_open_messages = ["Hello Welcome to EventCog", "Type in 'number' to get a number of events to browse upcoming events in the US", "Type in 'upcoming event' to see if we have more information", "Enter 'date' to get all event on and after that date", "Enter 'Let's See it All' to see up to 20 events", "When you are finished enter 'exit'"]
    attr_accessor :events
    def call
        create_events
        @@on_open_messages.each do |message|
            puts "#{message}\n"
        end
        input = gets.strip
        run(input)
    end

    def create_events
        events = []
        events = EventCog::API.new.fetch
        events.each do |e|
             EventCog::Event.new(e)
        end
    end

    def run(input) 
        while input != "exit"
            get_num_events if input == "number"
            # upcoming if input == "upcoming event"
            # get_event_by_date if input == "date"
            # get_all_events if input == "Let's See it All"
            puts "What else would you like to do"
            input = gets.strip
        end
        puts "Thank you For using EventCog"
    end


    def get_num_events
        count = 0
        puts "How many events would you like to see"
        num = gets.strip.to_i
        EventCog::Event.all.each do |e, index|
            if count >= num
                break
            else
                puts "#{count + 1}. #{e.name}: #{e.venue} at #{e.location} on #{e.date}\n url: #{e.url}\n\n"
            end
            count +=1
        end
    end 
            


        
        

end