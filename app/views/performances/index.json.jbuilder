json.array!(@performances) do |performance|
  json.extract! performance, :id, :title, :date, :performance_time, :call_time, :location, :event_leader, :leader_phone

  json.url performance_url(performance, format: :json)
end
