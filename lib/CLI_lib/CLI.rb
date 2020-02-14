class EventCog::CLI
    include EventCog

    @@on_open_messages = ["Enter 'number' to get a number of events to browse upcoming events in the US", "Enter 'upcoming events' to see if we have more information", "Enter 'date' to get all event on and after that date", "Enter 'Let's See it All' to see up to 20 events", "When you are finished enter 'exit'"]
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
        EventCog::API.new.fetch_api
        # binding.pry
    end

    def run(input) 
        did_run = false
        while input != "exit"
            if input == 'number'
                input = "exit" if get_num_events == false 
                did_run = true 
            elsif input == "upcoming events"
                input = "exit" if upcoming == false
                did_run = true
            elsif input == "date"
                input = "exit" if get_event_by_date == false
                did_run = true
            elsif input == "Let's See it All"
                get_all_events
                did_run = true
            end
            if input !='exit' && did_run == false
                puts '' +red('Sorry that choice is invalid') + ''
                puts '' +yellow('Enter What you would like to do') + ''
                input = gets.strip
            elsif input != 'exit' 
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
        input = gets.strip
        if input == 'exit'
            return false
        end
        num = input.to_i
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
        true
    end 
        
    def upcoming
        puts '' +yellow("What event would you like me to try to find?")+ ''
        search = gets.strip
        if search == 'exit'
            return false
        end
        puts '' +white("-------------------------") + ''
        find = EventCog::Event.find_by_name(search)
        if find.empty?
            puts '' +cyan('Sorry I cannot find anything on that yet try back later.') + ''
        else
            puts "\n"
            find.each_with_index do |event, index|
                event.list(index)
            end
        end
        puts '' +white("-------------------------") + ''
        true
    end

    def get_event_by_date
        count = 0
        puts ''+yellow("What date would you like to look for(format:yyyy-mm-dd)?") +''
        search = gets.strip
        if search == 'exit'
            return false
        end
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
        true
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