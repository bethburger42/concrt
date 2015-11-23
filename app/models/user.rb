class User < ActiveRecord::Base
  has_and_belongs_to_many :events

  # tell ActiveRecord that a user has_many friendships
  has_many :friendships
  has_many :friends, :through => :friendships

  # has_many :followers, class_name: "User",
  #                         foreign_key: "friend_id"
 
  # belongs_to :friend, class_name: "User"

  validates :email,
  presence: true,
  uniqueness: {case_sensitive: false},
  email: true

  validates :name,
  presence: true,
  length: {maximum: 20}

  has_secure_password

  validates_presence_of :password,
  confirmation: true

	def self.authenticate email, password
		User.find_by_email(email).try(:authenticate, password)
	end

 
    
  
end