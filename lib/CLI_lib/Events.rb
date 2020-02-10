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

    def self.find_by_name(name)
        self.all.find{|event| event.name == name}
    end 

    def self.find_by_date(date)
        self.all.collect {|event|event.date.strip("-").to_i >= date.strip("-").to_i} 
    end
end