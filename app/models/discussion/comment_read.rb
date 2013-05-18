module Discussion
  class CommentRead < ActiveRecord::Base
    attr_accessible :comment_id, :user_id
    belongs_to :user, class_name: Discussion.user_class
    belongs_to :comment, class_name: 'Discussion::Comment'

    validates :user_id, :comment_id, presence: true

    scope :by, ->(user) { where(user_id: user) }
    after_save :sync_thread_read

    private
    def sync_thread_read
      if self.read_at_changed? or self.id_changed?
        scope = self.comment.thread.thread_reads.by(self.user_id)
        thread_read = scope.first || scope.new

        total_unread = self.comment.thread.comments.joins(:comment_reads).
            where('discussion_comment_reads.read_at IS NULL AND user_id=?', user.id).count(distinct: true)

        thread_read.read = total_unread == 0

        thread_read.save
      end
    end
  end
end