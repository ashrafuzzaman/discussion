module Discussion
  class Thread < ActiveRecord::Base
    attr_accessible :initiator_id, :subject
    belongs_to :initiator, class_name: 'User'

    #scope :unread_by, ->(user) {
    #  joins(:message_recipients).where('messages_recipients.user_id = ? AND messages_recipients.read_at is NULL', user.id)
    #}
  end
end