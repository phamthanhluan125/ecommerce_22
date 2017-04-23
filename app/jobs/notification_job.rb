class NotificationJob < ApplicationJob
  queue_as :default

  def perform notification
    ActionCable.server.broadcast "#{notification.user_id}_notification_channel",
      noti: notification
  end
end
