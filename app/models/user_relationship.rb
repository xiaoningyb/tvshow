class UserRelationship < ActiveRecord::Base
  attr_accessible :user_id, :follower_id, :time, :type, :user, :follower

  #relationship between user <-> user
  belongs_to :user, :class_name => "User"
  belongs_to :follower, :class_name => "User"

  validates_presence_of :user_id
  validates_presence_of :follower_id
end
 
