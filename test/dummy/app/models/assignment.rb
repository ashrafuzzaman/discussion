class Assignment < ActiveRecord::Base
  attr_accessible :description, :text, :title
  has_many :threads, :class_name => 'Discussion::Thread', as: :topic
end