class EventCog::Event
    include EventCog
    @@all = []
    attr_accessor :name, :venue, :location, :url, :date
    def initialize(info_hash) #initialize new events from hash passed into initializer
        info_hash.each{|key, value| self.send(("#{key}="), value)}
        save
    end

    def save #save class instance to class variable
        @@all << self
    end

    def self.all #get all events
        @@all
    end

    def list(count) #list event 
        output = "#{count + 1}. #{self.name}: #{self.venue} at #{self.location}; on #{self.date}\n url: #{self.url}\n\n"
        puts '' +cyan(output)+ '' #set text color
    end

    def self.find_by_name(name) #find event by name
        self.all.find_all{|event| event.name == name}
    end 

    def self.find_by_date(date) #find event by date
        self.all.select do |event|
             event.date.split("-").join.to_i >= date.split("-").join.to_i
        end
    end
end