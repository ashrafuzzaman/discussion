module Discussion
  class Comment < ActiveRecord::Base
    attr_accessible :body
    validates :author_id, :body, presence: true

    belongs_to :author, class_name: Discussion.user_class
    belongs_to :commentable, polymorphic: true
    has_many :comment_reads, class_name: 'Discussion::CommentRead', dependent: :destroy

    after_create :update_last_posted_at, :create_comment_read_for_concerns, :update_total_comments_post

    def read_by!(user)
      my_comment_reads = self.comment_reads.where(user_id: user.id, comment_id: self.id)
      comment_read = my_comment_reads.first || my_comment_reads.new
      comment_read.read_at ||= Time.zone.now
      comment_read.save!
    end

    def read_by?(user)
      self.comment_reads.where('user_id = ? AND read_at IS NOT NULL', user.id).count > 0
    end

    private
    def update_last_posted_at
      if self.commentable.has_attribute?(:last_posted_at)
        self.commentable.update_column :last_posted_at, Time.zone.now
      end
    end

    def create_comment_read_for_concerns
      if self.commentable.kind_of?(Discussion::Thread)
        self.commentable.concern_users.each do |user|
          scope = self.comment_reads.by(user.id)
          scope.first || scope.create!(comment_id: self.id)
        end
      end
    end

    def update_total_comments_post
      if self.commentable.has_attribute?(:total_comments_post)
        self.commentable.update_column :total_comments_post, self.commentable.comments.count
      end
    end
  end
end