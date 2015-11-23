class SendPendingNotifications 

  include Sidekiq::Worker

  def perform
    p "perform pushes"
    notifications = Notification.pending

    notifications.each do |notification|
      if notification.fire_time.nil? || notification.fire_time < Time.now
        notification.send_notification
      end
    end

  end

  # Sidekiq::Cron::Job.create(name: 'Send notifications - every 1min', cron: '*/1 * * * *', class: 'SendPendingNotifications')

end