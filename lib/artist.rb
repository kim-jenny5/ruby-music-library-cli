class Artist
    extend Concerns::Findable

    attr_accessor :name

    @@all = []

    def initialize(name)
        @name = name
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
        artist = Artist.new(name)
        artist.save
        artist
    end

    def songs
        Song.all.select do |song|
            song.artist == self
        end
    end

    def add_song(song)
        if song.artist != self
            song.artist = self
        end
    end

    def genres
        songs.collect do |song|
            song.genre
        end.uniq
    end
end