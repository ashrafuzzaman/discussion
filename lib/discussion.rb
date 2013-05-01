require "discussion/engine"

module Discussion
  mattr_accessor :user_class
  self.user_class = 'User'
end