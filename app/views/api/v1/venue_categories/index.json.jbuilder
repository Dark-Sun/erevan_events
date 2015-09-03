json.venue_categories do 
	json.array! @venue_categories do |venue_category|
		json.extract! venue_category, :name
	end
end

json.venues do
	json.array!(@venues) do |venue|
		json.extract! venue, :id, :name, :fb_page, :phone, :address, :longitude, :latitude, :original_photo_url, :medium_photo_url, :thumb_photo_url
	end
end

json.events do 
	json.array!(@events) do |event|
		json.extract! event, :id, :venue_id, :name, :time, :original_photo_url, :medium_photo_url, :thumb_photo_url
	end
end

