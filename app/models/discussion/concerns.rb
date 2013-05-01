module Discussion
  class Concerns < ActiveRecord::Base
    attr_accessible :discussion_thread_id, :user_id
  end
end