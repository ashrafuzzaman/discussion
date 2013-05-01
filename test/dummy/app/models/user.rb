class User < ActiveRecord::Base
  attr_accessible :email, :password

  has_many :threads, :class_name => 'Discussion::Thread'

  has_many :discussion_concernses, :class_name => 'Discussion::Concerns'
  has_many :received_messages, :class_name => 'Discussion::Message', through: :discussion_concernses
  has_many :sent_messages, :class_name => 'Discussion::Message', foreign_key: 'author_id'
end