class User < ActiveRecord::Base
  attr_accessible :email, :password

  has_many :threads, :class_name => 'Discussion::Thread'

  has_many :discussion_concernses, :class_name => 'Discussion::Concerns'
  has_many :received_comments, :class_name => 'Discussion::Comment', through: :discussion_concernses
  has_many :sent_comments, :class_name => 'Discussion::Comment', foreign_key: 'author_id'
end