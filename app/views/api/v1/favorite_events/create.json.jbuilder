json:extract! favorite_event, :id
    
    json:event_id do
        json.extract! favorite_event.event, :id if favorite_event.event
    end