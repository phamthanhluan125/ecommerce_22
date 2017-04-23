class NotificationToAdminJob < ApplicationJob
  queue_as :default

  def perform notification
    ActionCable.server.broadcast "#{notification.user_id}_notification_channel",
      {notifiaction: notification}
  end
end
