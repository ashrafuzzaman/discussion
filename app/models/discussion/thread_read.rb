module Discussion
  class ThreadRead < ActiveRecord::Base
    attr_accessible :read, :thread_id, :user_id
    belongs_to :user, class_name: Discussion.user_class
    belongs_to :thread, class_name: 'Discussion::Thread'

    scope :by, ->(user) { where(user_id: user) }
  end
end