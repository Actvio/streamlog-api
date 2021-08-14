
class NotificationService < BaseService
  def create_notifications(source:, message:, notification_type:)
    user_ids = User.where.not(id: source.user_id)
      .subscribed_to_notification_type(notification_type)
      .pluck(:id)

    user_ids.each do |user_id|
      n = Notification.new(source: source, message: message, user_id: user_id, notification_type: notification_type)
      n.save
    end
  end

  def send_unread_notifications_as_emails
    ls = Notification
      .unread
      .not_email_notified
      .to_a
      .group_by(&:user_id)

    ls.each do |user_id, notifications|
      user = User.find user_id
      email_message = notifications.map {|n| n.message}.join("\n")
      user.send_email(email_message)
      Notification.where(id: notifications.map(&:id)).update_all email_notified: true
    end
  end
end