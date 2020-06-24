class EventCog::CLI
    include EventCog

    @@on_open_messages = ["Enter 'number' to get a number of events to browse upcoming events in the US", "Enter 'upcoming events' to see if we have more information", "Enter 'date' to get all event on and after that date", "Enter 'Let's See it All' to see up to 20 events", "Enter help to reprint these messages", "When you are finished enter 'exit'"]
    attr_accessor :events #CLI class instance read/write variable events
    def call #start application loop and set up
        create_events
        puts '' +yellow("Hello Welcome to EventCog") + ''
        puts '' +white("-------------------------") + ''
        print_messages
        puts '' +white("-------------------------") + ''
        input = gets.strip
        run(input)
    end

    def create_events
        EventCog::API.new.fetch_api #generate events from api
    end

    def print_messages
        @@on_open_messages.each do |message| #print out welcome message
            output = message 
            puts '' +cyan(output) + ''
        end
    end

    def run(input) #run loop
        did_run = false
        while input != "exit" #while user doesn't input exit continue running 
            case input #compare user input to preset values
            when 'number' 
                input = "exit" if get_num_events == false 
                did_run = true 
            when "upcoming events"
                input = "exit" if upcoming == false
                did_run = true
            when "date"
                input = "exit" if get_event_by_date == false
                did_run = true
            when "Let's See it All"
                get_all_events
                did_run = true
            when "help"
                print_messages
                did_run = true
            else
                continue
            end

            if input !='exit' && did_run == false #if user does not input exit and none of the above run then print out error
                puts '' +red('Sorry that choice is invalid') + ''
                puts '' +yellow('Enter What you would like to do') + ''
                input = gets.strip
            elsif input != 'exit' #prompt user input if they do not exit
                puts '' +yellow("What else would you like to do")+ ''
                input = gets.strip
                did_run = false
            end
        end
        puts '' +white("-------------------------") + ''
        puts '' +yellow("Thank you For using EventCog") + '' #exit message
    end

    def get_num_events
        count = 0
        puts '' +yellow("How many events would you like to see") + ''
        input = gets.strip #get user input of number of events
        if input == 'exit' #exit if user inputs exit
            return false
        end
        num = input.to_i #convert input into an integer
        puts '' +white("-------------------------") + ''
        EventCog::Event.all.each do |event| #get x number of events from Event class
            if count >= num
                break
            else
                event.list(count)
            end
            count +=1
        end
        puts '' +white("-------------------------") + ''
        true #return true to show that no error occured
    end 
        
    def upcoming
        puts '' +yellow("What event would you like me to try to find?")+ ''
        search = gets.strip #get user name search
        if search == 'exit' #exit if user inputs exit
            return false
        end
        puts '' +white("-------------------------") + ''
        find = EventCog::Event.find_by_name(search) #find events based on input
        if find.empty? #if nothing found output message below
            puts '' +cyan('Sorry I cannot find anything on that yet try back later.') + ''
        else #otherwise output each event and pass in index to event list function
            puts "\n"
            find.each_with_index do |event, index|
                event.list(index)
            end
        end
        puts '' +white("-------------------------") + ''
        true #return true to show that no error occured
    end

    def get_event_by_date
        count = 0
        puts ''+yellow("What date would you like to look for(format:yyyy-mm-dd)?") +''
        search = gets.strip #get user input of date
        if search == 'exit' #exit if user inputs exit
            return false
        end
        puts '' +white("-------------------------") + ''
        find = EventCog::Event.find_by_date(search) #use find by date function in events
        if find == nil #if none found output message below
            puts ''+cyan("Sorry I don't have anything on that yet try back later.") + ''
        else #otherwise
            puts "\n"
            find.each do |event| #output each event and pass count in to be list number
                event.list(count)
                count+=1
            end
        end
        puts '' +white("-------------------------") + ''
        true #return true to show that no error occured
    end

    def get_all_events
        count = 0
        puts ''+yellow("Drum Roll Please......") + ''
        puts ''+yellow("Here are all the event I have for now: ") + ''
        puts '' +white("-------------------------") + ''
        EventCog::Event.all.each do |event| #print out all events
            event.list(count) #pass in count to be list number
            count +=1
        end
        puts '' +white("-------------------------") + ''
    end
    
end

     