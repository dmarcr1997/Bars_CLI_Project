class EventCog::CLI
    include EventCog

    @@on_open_messages = ["Enter 'number' to get a number of events to browse upcoming events in the US", "Enter 'upcoming event' to see if we have more information", "Enter 'date' to get all event on and after that date", "Enter 'Let's See it All' to see up to 20 events", "When you are finished enter 'exit'"]
    attr_accessor :events
    def call
        create_events
        puts '' +yellow("Hello Welcome to EventCog") + ''
        puts '' +white("-------------------------") + ''
        @@on_open_messages.each do |message|
            output = message 
            puts '' +cyan(output) + ''
        end
        puts '' +white("-------------------------") + ''
        input = gets.strip
        run(input)
    end

    def create_events
        events = []
        events = EventCog::API.new.fetch_api
        events.each do |e|
             EventCog::Event.new(e)
        end
    end

    def run(input) 
        did_run = false
        while input != "exit"
            if input == 'number'
                get_num_events
                did_run = true 
            elsif input == "upcoming event"
                upcoming
                did_run = true
            elsif input == "date"
                get_event_by_date
                did_run = true
            elsif input == "Let's See it All"
                get_all_events
                did_run = true
            end
            if input !='exit' && did_run == false
                puts '' +red('Sorry that choice is invalid') + ''
                puts '' +yellow('Enter What you would like to do') + ''
                input = gets.strip
            else
                puts '' +yellow("What else would you like to do")+ ''
                input = gets.strip
                did_run = false
            end
        end
        puts '' +white("-------------------------") + ''
        puts '' +yellow("Thank you For using EventCog") + '' 
    end

    def get_num_events
        count = 0
        puts '' +yellow("How many events would you like to see") + ''
        num = gets.strip.to_i
        puts '' +white("-------------------------") + ''
        EventCog::Event.all.each do |event|
            if count >= num
                break
            else
                event.list(count)
            end
            count +=1
        end
        puts '' +white("-------------------------") + ''
    end 
        
    def upcoming
        puts '' +yellow("What event would you like me to try to find?")+ ''
        search = gets.strip
        puts '' +white("-------------------------") + ''
        find = EventCog::Event.find_by_name(search)
        if find == nil
            puts '' +cyan('Sorry I cannot find anything on that yet try back later.') + ''
        else
            puts "\n"
            find.list(0)
        end
        puts '' +white("-------------------------") + ''
    end

    def get_event_by_date
        count = 0
        puts ''+yellow("What date would you like to look for(format:yyyy-mm-dd)?") +''
        search = gets.strip
        puts '' +white("-------------------------") + ''
        find = EventCog::Event.find_by_date(search)
        if find == nil
            puts ''+cyan("Sorry I don't have anything on that yet try back later.") + ''
        else
            puts "\n"
            find.each do |event|
                event.list(count)
                count+=1
            end
        end
        puts '' +white("-------------------------") + ''
    end

    def get_all_events
        count = 0
        puts ''+yellow("Drum Roll Please......") + ''
        puts ''+yellow("Here are all the event I have for now: ") + ''
        puts '' +white("-------------------------") + ''
        EventCog::Event.all.each do |event|
            event.list(count)
            count +=1
        end
        puts '' +white("-------------------------") + ''
    end
    
end