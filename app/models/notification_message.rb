class NotificationMessage < ApplicationRecord
  belongs_to :user

  scope :notification_of_user_not_seen, ->(user_id){where("user_id = ?
    AND status = 0", user_id).order("created_at desc").limit(Settings.maximum_notify_message)}
  scope :notification_of_user_seen, -> (user_id, limit){where("user_id = ?
    AND status = 1", user_id).order("created_at desc").limit(limit)}
  scope :all_notification_not_seen, ->(user_id){where "user_id = ? AND status = 0", user_id}
end
