class User < ActiveRecord::Base
  has_and_belongs_to_many :events

  # tell ActiveRecord that a user has_many friendships
  has_many :friendships
  has_many :friends, :through => :friendships

  # has_many :followers, class_name: "User",
  #                         foreign_key: "friend_id"
 
  # belongs_to :friend, class_name: "User"
end