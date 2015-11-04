class SendPendingNotifications 

  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { minutely(1) } 

  def perform
    notifications = Notification.pending

    notifications.each do |notification|
      if notification.fire_time < Time.now || notification.fire_time.nil?
        notification.send
      end
    end

  end

end