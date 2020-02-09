class BarFinder::CLI
    def call
       BarFinder::API.new.fetch
    end
end