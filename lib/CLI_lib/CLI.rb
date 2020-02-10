class EventFinder::CLI
    def call
       EventFinder::API.new.fetch
    end
end