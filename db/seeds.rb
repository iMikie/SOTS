require 'CSV'


def import_CSV_of_songs
  headers = [:title, :song_number, :composer, :arranger_one, :arranger_two, :voicing, :category]
  csv_text = File.read("db/SOTS_Library.csv")
  song_hash = {}
  csv_array = CSV.parse(csv_text) do |row|
    row.each_with_index { |element, index| song_hash[headers[index]] = element }

    song_hash[:song_number] = song_hash[:song_number].to_i
    song = Song.create!(song_hash)
  end

end

import_CSV_of_songs



as_game = Performance.create( title: "Oakland A's game",
                    date: Date.new(2015, 7, 21),
                    performance_time: Time.new(2015, 7, 10, 19, 05, 0),
                    call_time: Time.new(2015, 7, 10, 17, 0, 0),
                    location: "Suites entrance which is located in between  the A's coliseum and the Oracle Arena where the Warriors play. It's on the top of the walkway",
                    event_leader: "Saverio DeLuca",
                    leader_phone: "(925)788-5252")

star_spangled_banner = Song.where(song_number: 350).first
as_game.songs << star_spangled_banner

canadian_anthem = Song.create(song_number: 1075, title:"O Canada", arranger_one: "Herb Goodrich", voicing: "TTBB with Trumpet", category: "Patriotic Anthem")

as_game.songs << canadian_anthem