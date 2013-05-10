module Discussion
  class Concerns < ActiveRecord::Base
    attr_accessible :thread_id, :user_id
    belongs_to :thread, class_name: 'Discussion::Thread'
    belongs_to :user, class_name: Discussion.user_class

    after_create :create_thread_read, :create_message_read_for_messages

    private
    def create_thread_read
      scope = self.thread.thread_reads.by(self.user_id)
      thread_read = scope.first || scope.new
      thread_read.read = false
      thread_read.save!
    end

    def create_message_read_for_messages
      self.thread.messages.each do |msg|
        scope = msg.message_reads.by(self.user_id)
        scope.first || scope.create!
      end
    end
  end
end