class NotificationJob < ApplicationJob
  queue_as :default

  def perform user_id, notification
    ActionCable.server.broadcast "#{user_id}_notification_channel",
      {notifiaction: notification}
  end

end
