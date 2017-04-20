class NotificationMessagesController < ApplicationController
  def update
    noti = NotificationMessage.find_by id: params[:notification_messages][:noti_id]
    if noti
      noti.status = 1
      noti.save
    end
  end
end
