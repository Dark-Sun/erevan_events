json.array!(@venues) do |venue|
	json.extract! venue, :id, :name, :fb_page, :phone, :address, :longtitude, :latitude, :original_photo_url, :medium_photo_url, :thumb_photo_url
	json.events(venue.events) do |event|
		json.extract! event, :id, :venue_id, :name, :time, :original_photo_url, :medium_photo_url, :thumb_photo_url
	end
end
