class CreatePerformances < ActiveRecord::Migration
  def change
    create_table  :performances do |t|
      t.string    :title, limit: 50
      t.date      :date
      t.time      :performance_time
      t.time      :call_time
      t.string    :location
      t.string    :event_leader
      t.string    :leader_phone

      t.timestamps

    end
  end
end
