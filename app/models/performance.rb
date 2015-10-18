class Performance < ActiveRecord::Base
  validates :title, :presence => true
  validates :date, :presence => true

  has_many :performance_songs
  has_many :songs, :through =>  :performance_songs  #enables Performance.first.songs
                                                    #enables you to add a song to a performance:
                                                    # @performance.songs << @song
end
