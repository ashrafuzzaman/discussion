module Discussion
  class Message < ActiveRecord::Base
    attr_accessible :body, :thread_id
    validates :author_id, :body, presence: true

    belongs_to :author, :class_name => Discussion.user_class
    belongs_to :thread, :class_name => 'Discussion::Thread', :inverse_of => :messages, :counter_cache => :total_messages_post
    has_many :message_reads, :class_name => 'Discussion::MessageRead'

    after_create :update_last_posted_at

    def read_by!(user)
      my_message_reads = self.message_reads.where(user_id: user.id, message_id: self.id)
      message_read = my_message_reads.first || my_message_reads.new
      message_read.read_at ||= Time.zone.now
      #ap message_read
      message_read.save!
    end

    def read_by?(user)
      self.message_reads.where(user_id: user.id).count > 0
    end

    private
    def update_last_posted_at
      self.thread.update_column :last_posted_at, Time.zone.now
    end

  end
end