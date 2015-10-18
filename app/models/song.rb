class Song < ActiveRecord::Base
  validates :song_number, :presence => true
  validates :title, :presence => true

  has_many :performance_songs
  has_many :performances, :through =>  :performance_songs
end
