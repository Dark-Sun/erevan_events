class VenuePhoto < ActiveRecord::Base

  validates :photo_url, presence: true
  
  belongs_to :venue

  def self.create_from_facebook(venue_id)
    @oauth = Koala::Facebook::OAuth.new '1629797193971618', '09f53232d9bfdf5e8e7afa2769fc4ecc'
    @graph = Koala::Facebook::API.new @oauth.get_app_access_token

    return unless Venue.exists?(venue_id)
    venue     = Venue.find(venue_id)
    page_name = venue.fb_page.split('/')[-1].squish
    id        = @graph.get_object("#{page_name}")["id"]
    photos    = @graph.get_object("#{id}/photos?fields=images&type=uploaded")

    photos.each do |photo_urls|
      sorted = photo_urls['images'].sort_by { |photo| photo['width'] }
      next if exists?(photo_url: sorted.last['source'])
      create(venue: venue, photo_url:  sorted.last['source'], thumb_url:  sorted.first['source'])
    end

  end

end
