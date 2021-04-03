class Genre
    extend Concerns::Findable
    
    attr_accessor :name

    @@all = []

    def initialize(name)
        @name = name
        @@all
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def save
        @@all << self
    end

    def self.create(name)
        genre = Genre.new(name)
        genre.save
        genre
    end

    def songs
        Song.all.select do |song|
            song.genre == self
        end
    end

    def artists
        songs.collect do |song|
            song.artist
        end.uniq
    end
end