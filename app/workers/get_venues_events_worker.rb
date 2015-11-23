class GetVenuesEventsWorker 

  include Sidekiq::Worker

  def perform
    p "update!"
    Venue.connection
    Venue.all.each do |venue|
      p "#{venue.id} - #{venue.name}"
      GetVenueEventsWorker.perform_async(venue.id)
    end
  end

  # Sidekiq::Cron::Job.create(name: 'Get events - every 15min', cron: '*/15 * * * *', class: 'GetVenuesEventsWorker')


end