module Discussion
  class MessageRead < ActiveRecord::Base
    attr_accessible :message_id, :user_id
    belongs_to :user, class_name: Discussion.user_class
    belongs_to :message, class_name: 'Discussion::Message'

    validates :user_id, :message_id, presence: true

    scope :by, ->(user) { where(user_id: user) }
    after_save :sync_thread_read

    private
    def sync_thread_read
      if self.read_at_changed? or self.id_changed?
        scope = self.message.thread.thread_reads.by(self.user_id)
        thread_read = scope.first || scope.new

        total_unread = self.message.thread.messages.joins(:message_reads).
            where('discussion_message_reads.read_at IS NULL AND user_id=?', user.id).count(distinct: true)

        thread_read.read = total_unread == 0

        thread_read.save
      end
    end
  end
end