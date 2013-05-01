module Discussion
  class Concerns < ActiveRecord::Base
    attr_accessible :thread_id, :user_id
  end
end