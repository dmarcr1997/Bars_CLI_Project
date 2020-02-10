class EventCog::CLI
    @@on_open_messages = ["Hello Welcome to EventCog"]
    def call
       EventFinder::API.new.fetch
    end
end