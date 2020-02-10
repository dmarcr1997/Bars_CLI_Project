class EventCog::Event
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
        puts "#{count + 1}. #{self.name}: #{self.venue} at #{self.location}; on #{self.date}\n url: #{self.url}\n\n"
    end

    def self.list_all
        self.all.each_with_index do |event, index|
            puts "#{index + 1}. #{event.name}: #{event.venue} at #{event.location}; on #{event.date}\n url: #{event.url}\n\n"
        end
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