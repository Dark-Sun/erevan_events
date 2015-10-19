class GetVenuesEventsWorker 

  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { hourly(1) } #{ minutely(1) } 

  def perform
    p "update!"
    Venue.connection
    Venue.all.each do |venue|
      GetVenueEventsWorker.perform_async(venue.id)
    end
  end

end