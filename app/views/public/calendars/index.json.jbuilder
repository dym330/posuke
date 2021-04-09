json.array!(@schedules) do |schedule|
  json.extract! schedule, :id, :title, :content
  json.start schedule.start_time
  json.end schedule.end_time
  json.allDay false
  json.url schedule_url(schedule, format: :html) 
end