json.array! @favorite_venues do |venue|
	json.extract! venue, :id
	json.venue_id do
	    json.extract! venue.venue, :id if venue.venue
	end
end
