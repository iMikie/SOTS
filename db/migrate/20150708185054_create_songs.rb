class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.integer :song_number
      t.string  :title, limit: 64
      t.string  :composer, limit: 64
      t.string  :larger_work, limit: 64
      t.string  :arranger_one, limit: 64
      t.string  :arranger_two, limit: 64
      t.string  :voicing, limit: 8
      t.string  :category

      t.timestamps
    end
  end
end
