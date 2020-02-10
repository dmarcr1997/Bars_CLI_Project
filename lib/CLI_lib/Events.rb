class EventCog::Event
    include EventCog

    @@all = []
    attr_accessor :name, :venue, :location, :url, :date
    def initialize(info_hash)
        info_hash.each{|key, value| self.send(("#{key}="), value)}
        save
    end

    def save
        @@all << self
    end

    def self.all
        @@all
    end

    def list(count)
        output = "#{count + 1}. #{self.name}: #{self.venue} at #{self.location}; on #{self.date}\n url: #{self.url}\n\n"
        puts '' +cyan(output)+ ''
    end

    def self.find_by_name(name)
        self.all.find{|event| event.name == name}
    end 

    def self.find_by_date(date)
        events = []
        self.all.collect do |event|
            if event.date.split("-").join.to_i >= date.split("-").join.to_i
                events << event
            else
            end
        end
        if events.empty?
            nil
        else
            events 
        end
    end
end