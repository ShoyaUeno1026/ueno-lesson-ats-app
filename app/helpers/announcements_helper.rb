module AnnouncementsHelper
  def unread_announcements(user)
    last_announcement = Announcement.order(published_at: :desc).first
    return if last_announcement.nil?

    if user.nil? || user.announcements_read_at.nil? || user.announcements_read_at < last_announcement.published_at
      "unread-announcements"
    end
  end
end
