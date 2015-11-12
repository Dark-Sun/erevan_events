class GetVenuesEventsWorker 

  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { minutely(15) } #{ minutely(1) } 

  def perform
    p "update!"
    Venue.connection
    Venue.all.each do |venue|
      p "#{venue.id} - #{venue.name}"
      GetVenueEventsWorker.perform_async(venue.id)
      # sleep 30
    end
  end

end