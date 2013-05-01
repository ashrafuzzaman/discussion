module Discussion
  class Message < ActiveRecord::Base
    attr_accessible :body, :thread_id
    validates :author_id, presence: true

    belongs_to :author, :class_name => 'User'
    belongs_to :thread, :class_name => 'Discussion::Thread'
    has_many :message_reads, :class_name => 'Discussion::MessageRead'

    def read_by?(user)
      self.message_reads.where(author_id: user.id, read_at: nil).count > 0
    end
  end
end