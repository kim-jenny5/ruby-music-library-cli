class Song
    attr_accessor :name
    attr_reader :artist, :genre

    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist = artist if artist
        self.genre = genre if genre
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
        song = Song.new(name)
        song.save
        song
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        if self.genre != genre
            self.genre = genre
        end
    end

    def self.find_by_name(name)
        self.all.find do |song|
            song.name == name
        end
    end

    def self.find_or_create_by_name(name)
        self.find_by_name(name) ? self.find_by_name(name): self.create(name)
    end

    def self.new_from_filename(name)
        section = name.split(" - ")
        artist_name = section[0]
        song_name = section[1]
        genre = section[2].split(".")[0]

        artist = Artist.find_or_create_by_name(artist_name)
        genre_2 = Genre.find_or_create_by_name(genre) 

        song_instance = Song.new(song_name, artist, genre_2)
    end

    def self.create_from_filename(name)
        Song.new_from_filename(name).save
    end
end