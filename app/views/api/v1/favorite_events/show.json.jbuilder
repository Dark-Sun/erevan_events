json.array! @favorite_events do |event|
	json.extract! event, :id
	json.event_id do
	    json.extract! event.event, :id if event.event
	end
end
