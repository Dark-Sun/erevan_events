
 json.extract! @user,  :id, 
    :phone,
	:name,
	:email

json.notifications do
	json.array!(@user.sent_notifications) do |notification|
		json.extract! notification, :id, :message, :message_armenian, :message_russian, :fire_time, :sent
		
		json.venue_id do
	    	json.extract! notification.venue, :id if notification.venue_id
	  	end

		json.event_id do
	    	json.extract! notification.event, :id if notification.event_id
	  	end
 	end
end
