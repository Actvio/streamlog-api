
namespace :music_sniper do
  desc "Send notifications to people that have unread notifications from today."
  task send_notifications: :environment do
    NotificationService.new.send_unread_notifications_as_emails
  end
end