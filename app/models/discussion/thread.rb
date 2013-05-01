module Discussion
  class Thread < ActiveRecord::Base
    attr_accessible :subject, :messages_attributes
    validates :subject, presence: true

    belongs_to :initiator, :class_name => Discussion.user_class
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

    scope :order_by_recent, order('discussion_threads.last_posted_at DESC')

    scope :concerns_with, ->(user) {
      joins('LEFT OUTER JOIN discussion_concerns ON discussion_concerns.thread_id = discussion_threads.id').
          where('discussion_concerns.user_id=:user_id OR discussion_threads.initiator_id=:user_id', user_id: user.id)
    }

    def read_by?(user)
      number_of_unread_messages_by(user) == 0
    end

    def number_of_read_messages_by(user)
      @number_of_unread_messages ||= {}
      @number_of_unread_messages[user.id] ||= self.messages.joins(:message_reads).where('discussion_message_reads.user_id = ?', user.id).count
    end

    def number_of_unread_messages_by(user)
      total_messages_post - number_of_read_messages_by(user)
    end
  end
end