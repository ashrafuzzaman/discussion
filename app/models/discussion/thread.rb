module Discussion
  class Thread < ActiveRecord::Base
    attr_accessible :initiator_id, :subject, :messages_attributes, :messages
    belongs_to :initiator, class_name: 'User'
    has_many :messages, :class_name => 'Discussion::Message'

    accepts_nested_attributes_for :messages

    #scope :unread_by, ->(user) {
    #  joins(:message_recipients).where('messages_recipients.user_id = ? AND messages_recipients.read_at is NULL', user.id)
    #}
  end
end