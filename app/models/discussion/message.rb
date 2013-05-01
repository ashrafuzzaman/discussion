module Discussion
  class Message < ActiveRecord::Base
    attr_accessible :author_id, :body, :thread_id
    belongs_to :thread, :class_name => 'Discussion::Thread'
    has_many :message_reads, :class_name => 'Discussion::MessageRead'

    def read_by?(user)
      self.discussion_message_reads.where(user_id: user.id, read_at: nil).count > 0
    end
  end
end