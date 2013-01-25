class UserRelationshipController < ApplicationController
  before_filter :authenticate_user!

  def create
    user = User.find(params[:user])
    follower = User.find(params[:follower])
    self.create_relationsip(user, follower)
  end

  def destory
    user = User.find(params[:user])
    follower = User.find(params[:follower])
    self.destory_relationsip(user, follower)
  end

  def self.create_relationship(user, follower)
    user.transaction do 
      user.update_attributes(:follower_count => user.follower_count.next)
      user.update_attributes(:version => user.version.next)
      follower.update_attributes(:followee_count => follower.followee_count.next)
      follower.update_attributes(:version => follower.version.next)
      UserRelationship.create(:user => user, :follower => follower, :type => 0, :time => Time.now)
    end
  end

  def self.destory_relationship(user, follower)
    user.transaction do 
      user.update_attributes(:follower_count => (user.follower_count-1) )
      user.update_attributes(:version => user.version.next)
      follower.update_attributes(:followee_count => (follower.followee_count-1) )
      follower.update_attributes(:version => follower.version.next)
      UserRelationship.destory(:user => user, :follower => follower)
    end
  end
  
end
