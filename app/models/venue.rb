class Venue < ActiveRecord::Base

    attr_accessor :from_facebook

    belongs_to :venue_category
    
    before_save proc { get_from_facebook if @from_facebook == "true" }
    after_commit     { GetVenueEventsWorker.perform_async(self.id) }
    
    has_many :events

    has_attached_file :photo, 
                       styles: { medium: "300x300", thumb: "150x150" }
    has_attached_file :cover, 
                       styles: { medium: "300x600", thumb: "150x300" }
                       
    validates_attachment_content_type :photo, content_type: ["image/jpg", "image/jpeg", "image/png"]
    validates_attachment_content_type :cover, content_type: ["image/jpg", "image/jpeg", "image/png"]

    validates :fb_page, uniqueness: true
    # validates :name, presence: true, length: { maximum: 30 }

    def original_photo_url
      photo.url(:original)
    end

    def medium_photo_url
      photo.url(:medium)
    end

    def thumb_photo_url
      photo.url(:thumb)
    end

    def get_from_facebook
      begin
        @oauth = Koala::Facebook::OAuth.new '1629797193971618', '09f53232d9bfdf5e8e7afa2769fc4ecc'
        @graph = Koala::Facebook::API.new @oauth.get_app_access_token
        # p @events = @graph.get_object('https://www.facebook.com/pages/Nintendo-64/108323935856675?fref=ts'.split("/").last).to_hash["id"]
        # p '+++++++++++++++++++++++++++++++++++'
        # @page = @graph.get_object('salonarmenian?fields=name,website,phone,location,about,description,cover,category,place_topics')
        # @page = @graph.get_object("#{self.fb_page.to_s}?fields=name,website,phone,location,about,description,cover,category,place_topics")
#
        @page = @graph.get_object("#{self.fb_page.split(/.*facebook.com/)[1]}?fields=name,website,phone,location,about,description,cover,category,place_topics") # gets fb page name (string after *facebook.com)
        if VenueCategory.where(name: @page['category']).any?
          self.venue_category = VenueCategory.where(name: @page['category']).first
        else
          v = VenueCategory.create(name: @page['category'])
          self.venue_category = v
        end
        # @page = @graph.get_object(self.fb_page)
        # p @page
        # p "-----------------------------------"
        # @page
        # p @events = @graph.get_object('salonarmenian/events?&q=a&limit=100&since=now&until=next year')
        # p "-----------------------------------"

        # p '+++++++++++++++++++++++++++++++++++'
        # p @events = @graph.get_object('Club12.Erevan/events?&q=a&limit=100&since=now&until=next year&fields=picture,name,description,start_time')
        # p '+++++++++++++++++++++++++++++++++++'

        # p '+++++++++++++++++++++++++++++++++++'
        # p @venue_info = @graph.get_object('salonarmenian?fields=website,phone,location,about,description')
        # p '+++++++++++++++++++++++++++++++++++'

        # p '+++++++++++++++++++++++++++++++++++'
        # p @venue_picture = @graph.get_object('salonarmenian/picture?type=large&redirect=false')
        # p '+++++++++++++++++++++++++++++++++++'
        p '+++++++'

        self.name        = @page['name']
        self.description = @page['description']
        self.address     = @page['location']['street']  + ', ' + @page['location']['city'] + ', ' +
                           @page['location']['country'] if @page['location']
        self.phone       = @page['phone']
        self.longitude   = @page['location']['longitude'] if @page['location']
        self.latitude    = @page['location']['latitude'] if @page['location']
        self.cover       = URI.parse(@page['cover']['source']) if @page['cover']
        self.photo       = URI.parse(@graph.get_object('salonarmenian/picture?type=large&redirect=false')['data']['url'])
      rescue Exception => e 
        errors.add(:fb_page, "Importing data from #{self.fb_page} page was not completed successfully. #{e.message}")
      end

    end

    def get_events
      venue = self

      @oauth = Koala::Facebook::OAuth.new '1629797193971618', '09f53232d9bfdf5e8e7afa2769fc4ecc'
      @graph = Koala::Facebook::API.new @oauth.get_app_access_token

      @events = @graph.get_object("#{venue.fb_page.split(/.*facebook.com/)[1]}/events?&q=a&limit=100&since=now&until=next year&fields=cover,name,description,start_time")
      logger.debug '------'
      logger.debug @events
      @events.each do |f_event|
        event = Event.new
        event.venue_id = self.id
        event.name = f_event['name']
        event.time = f_event['start_time']
        event.photo = f_event['cover']['source'] if f_event['cover']
        event.description = f_event['description']
        event.save
        logger.debug event.errors
      end
    end


    def from_facebook=(value)
      @from_facebook = value
    end
end
