module Discussion
  class MessageRead < ActiveRecord::Base
    attr_accessible :message_id, :user_id
  end
end