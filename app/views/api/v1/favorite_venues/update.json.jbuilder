json.extract! @favorite_venue, :id, :user_id
    
json.venue_id do
    json.extract! @favorite_venue.venue, :id if @favorite_venue.venue
end