class NotificationMessage < ApplicationRecord
  belongs_to :user

  scope :notification_of_user, ->(user_id, limit){where("user_id = ?
    AND status = 0", user_id).order("created_at desc").limit(limit)}
  scope :notification_of_user_readed, -> (user_id, limit){where("user_id = ?
    AND status = 1", user_id).order("created_at desc").limit(limit)}
end
