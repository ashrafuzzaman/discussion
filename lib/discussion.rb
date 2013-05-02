require "discussion/engine"

module Discussion
  mattr_accessor :user_class
  self.user_class = 'User'

  mattr_accessor :ajaxify
  self.ajaxify = true

  mattr_accessor :ajax_wrapper_id
  self.ajax_wrapper_id = 'discussion_block'
end