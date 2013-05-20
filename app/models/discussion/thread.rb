module Discussion
  class Thread < ActiveRecord::Base
    attr_accessible :subject, :comments_attributes, :concern_user_ids
    validates :subject, presence: true

    belongs_to :topic, polymorphic: true

    belongs_to :initiator, class_name: Discussion.user_class
    has_many :comments, as: :commentable, dependent: :destroy

    has_many :concerns, class_name: 'Discussion::Concerns', dependent: :destroy
    has_many :concern_users, through: :concerns, source: Discussion.user_class.underscore.to_sym

    has_many :thread_reads, class_name: 'Discussion::ThreadRead', dependent: :destroy

    accepts_nested_attributes_for :comments
    before_create :add_initiator_to_concerns

    # use the count with distinct: true as following
    # Discussion::Thread.read_by(User.first).count(distinct: true)
    scope :by_user_and_status, ->(user, read) {
      joins(:thread_reads).where('discussion_thread_reads.user_id = ? AND discussion_thread_reads.read = ?', user.id, read)
    }

    scope :by_initiator, ->(user) {
      where(initiator_id: user.id)
    }

    scope :read_by, ->(user) {
      by_user_and_status(user, true)
    }

    scope :unread_by, ->(user) {
      by_user_and_status(user, false)
    }

    scope :order_by_recent, order('discussion_threads.last_posted_at DESC')

    scope :concerns_with, ->(user) {
      joins(:concerns).where('discussion_concerns.user_id=?', user.id)
    }
    scope :sent_item_for, ->(user) { where(initiator_id: user.id) }

    def read_by?(user)
      self.thread_reads.by(user).where(read: false).count == 0
    end

    def self.total_unread_by(user)
      Rails.cache.fetch("total_unread_thread_by_#{user.id}", expires_in: 10.minutes) do
        Thread.unread_by(user).count
      end
    end

    def number_of_read_comments_by(user)
      @number_of_unread_comments ||= {}
      @number_of_unread_comments[user.id] ||= self.comments.
          joins(:comment_reads).where('discussion_comment_reads.user_id = ? AND discussion_comment_reads.read_at IS NOT NULL', user.id).count
    end

    def number_of_unread_comments_by(user)
      self.total_comments_post - number_of_read_comments_by(user)
    end

    private
    def add_initiator_to_concerns
      self.concern_users << self.initiator
    end
  end
end