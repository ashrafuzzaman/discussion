module Discussion
  class Thread < ActiveRecord::Base
    attr_accessible :subject, :messages_attributes, :messages
    belongs_to :initiator, class_name: 'User'
    has_many :messages, :class_name => 'Discussion::Message', :inverse_of => :thread

    has_many :concerns, class_name: 'Discussion::Concerns'
    has_many :concern_users, class_name: 'User', through: :concerns

    accepts_nested_attributes_for :messages

    # use the count with distinct: true as following
    # Discussion::Thread.read_by(User.first).count(distinct: true)
    scope :read_by, ->(user) {
      select("DISTINCT *").joins(:messages => :message_reads).where('discussion_message_reads.user_id = ?', user.id)
    }

    #scope :unread_by, ->(user) {
    #  select("DISTINCT *").joins(:messages => :message_reads).where('discussion_message_reads.user_id = ?', user.id)
    #}
  end
end