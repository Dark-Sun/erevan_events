json.venue_categories do 
	json.array! @venue_categories do |venue_category|
		json.extract! venue_category, :id, :name, :original_image_url, :thumb_image_url
	end
end

json.venues do
	json.array!(@venues) do |venue|
		json.extract! venue, :id, :name, :fb_page, :phone, :address, :description, :longitude, :latitude, :original_photo_url, :medium_photo_url, :thumb_photo_url
		
		json.venue_category_id do
	    	json.extract! venue.venue_category, :id if venue.venue_category
	  	end
	end
end

json.events do 
	json.array!(@events) do |event|
		json.extract! event, :id, :name, :description, :time, :original_photo_url, :medium_photo_url, :thumb_photo_url

		json.venue_id do
	    	json.extract! event.venue, :id if event.venue
	  	end
	end
end

json.venue_photos do
	json.array!(@venue_photos) do |photo|
		json.extract! photo, :id, :photo_url, :thumb_url

		json.venue_id do
			json.extract! photo.venue, :id if photo.venue
		end
	end
end

json.user_categories do
	json.array!(@user_categories) do |category|
		json.extract! category, :id, :name
	end
end