class SendPendingNotifications 

  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { minutely(1) } 

  def perform
    p "perform pushes"
    notifications = Notification.pending

    notifications.each do |notification|
      if notification.fire_time.nil? || notification.fire_time < Time.now
        notification.send_notification
      end
    end

  end

end