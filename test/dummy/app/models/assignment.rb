class Assignment < ActiveRecord::Base
  attr_accessible :description, :text, :title
  has_many :threads, :class_name => 'Discussion::Thread', as: :topic
  has_many :comments, class_name: 'Discussion::Comment', as: :commentable, dependent: :destroy
end