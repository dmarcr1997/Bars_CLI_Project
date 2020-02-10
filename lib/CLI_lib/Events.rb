class EventFinder::Events
    @@all = []
    attr_reader :name, :venue, :location, :url, :date
    def initialize(name, venue, location, url, date)
        @name = name
        @venue = venue
        @location = location
        @url = url
        @date = date
        save
    end

    def create_from_hash(info_hash)
        info_hash.each{|key, value| self.send(("#{key}="), value)}
    end

    def save
        @@all = self
    end

end