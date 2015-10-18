class CreatePerformanceSongs < ActiveRecord::Migration
  def change
    create_table :performance_songs do |t|
      t.integer  :performance_id
      t.integer  :song_id

      t.timestamps
    end
  end
end
