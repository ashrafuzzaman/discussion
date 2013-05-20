module Discussion
  class Comment < ActiveRecord::Base
    attr_accessible :body
    validates :author_id, :body, presence: true

    belongs_to :author, class_name: Discussion.user_class
    #belongs_to :thread, class_name: 'Discussion::Thread', inverse_of: :comments, counter_cache: :total_comments_post
    belongs_to :commentable, polymorphic: true, counter_cache: :total_comments_post
    has_many :comment_reads, class_name: 'Discussion::CommentRead', dependent: :destroy

    after_create :update_last_posted_at, :create_comment_read_for_concerns

    def read_by!(user)
      my_comment_reads = self.comment_reads.where(user_id: user.id, comment_id: self.id)
      comment_read = my_comment_reads.first || my_comment_reads.new
      comment_read.read_at ||= Time.zone.now
      comment_read.save!
    end

    def read_by?(user)
      self.comment_reads.where(user_id: user.id).where('read_at IS NOT NULL').count > 0
    end

    private
    def update_last_posted_at
      self.commentable.update_column :last_posted_at, Time.zone.now
    end

    def create_comment_read_for_concerns
      #raise self.comment_reads.by(user.id).new.inspect
      self.commentable.concern_users.each do |user|
        scope = self.comment_reads.by(user.id)
        scope.first || scope.create!(comment_id: self.id)
      end
    end

  end
end