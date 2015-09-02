class GetVenuesEventsWorker 

  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { minutely(5) } #{ hourly(1) }

  def perform
    Venue.connection
    Venue.all.each do |venue|
      GetVenueEventsWorker.perform_async(venue.id)
    end
  end

end