class Venue < ActiveRecord::Base

    attr_accessor :from_facebook

    belongs_to :venue_category
    has_many   :venue_photos, dependent: :destroy
    has_many   :events,       dependent: :destroy

    before_save proc { get_from_facebook if @from_facebook == "true" }
    after_commit { GetVenueEventsWorker.perform_async(self.id) }
    after_commit { VenuePhoto.create_from_facebook(self.id) }

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

        page_name = self.fb_page.split('/')[-1].squish
        id        = @graph.get_object("#{page_name}")["id"]
        @page     = @graph.get_object("#{id}?fields=name,website,phone,location,about,description,cover,category,place_topics") # gets fb page name (string after *facebook.com)

        self.venue_category   = VenueCategory.where(name: @page['category']).first
        self.venue_category ||= VenueCategory.create(name: @page['category'])
       
        self.name        = @page['name']
        self.description = @page['description']
        self.address     = "#{@page['location']['street']}, #{@page['location']['city']}, #{@page['location']['country']}" if @page['location']
        self.phone       = @page['phone']
        self.longitude   = @page['location']['longitude'] if @page['location']
        self.latitude    = @page['location']['latitude'] if @page['location']
        self.cover       = URI.parse(@page['cover']['source']) if @page['cover']
        self.photo       = URI.parse("https://graph.facebook.com/#{id}/picture?width=9999")

      rescue Exception => e 
        errors.add(:fb_page, "Importing data from #{self.fb_page} page was not completed successfully. #{e.message}")
      end

    end

    def from_facebook=(value)
      @from_facebook = value
    end
end
