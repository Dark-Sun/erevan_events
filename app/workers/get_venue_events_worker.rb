class GetVenueEventsWorker 

  include Sidekiq::Worker
  
  def perform(venue_id)
    venue = Venue.find(venue_id)

    @oauth = Koala::Facebook::OAuth.new '1629797193971618', '09f53232d9bfdf5e8e7afa2769fc4ecc'
    @graph = Koala::Facebook::API.new @oauth.get_app_access_token

    page_name = venue.fb_page.split('/')[-1].squish
    id = @graph.get_object("#{page_name}")["id"]

    @events = @graph.get_object("#{id}/events?&q=a&limit=100&since=now&until=next year&fields=cover,name,description,start_time")
    # @events = @graph.get_object("#{id}/events")
    @events.each do |f_event|
      event                 = Event.where(facebook_id: f_event['id']).first if Event.exists?(facebook_id: f_event['id'])
      event               ||= Event.new
      event.venue_id        = venue.id
      event.name            = f_event['name']
      event.name_ru         = f_event['name']
      event.name_arm        = f_event['name']
      event.time            = f_event['start_time']
      event.photo           = f_event['cover']['source'] if f_event['cover']
      event.description     = f_event['description']
      event.description_arm = f_event['description']
      event.description_ru  = f_event['description']
      event.facebook_id     = f_event['id']
      event.save if event.name_changed? || event.description_changed?
      # logger.debug event.errors
    end
  end

end