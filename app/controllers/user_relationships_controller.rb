class UserRelationshipsController < ApplicationController      
  #before_filter :authenticate_user!, :except => [:index, :show]

  def create
    user = User.find(params[:user])
    follower = User.find(params[:follower])
    if (params["_method"] != nil) && (params["_method"] == "delete")
      UserRelationshipsController.destroy_relationship(user, follower)
    else
      UserRelationshipsController.create_relationship(user, follower)
    end    

    redirect_to :controller => "users", :action => :show, :id => user
  end

  def destroy
    user = User.find(params[:user])
    follower = User.find(params[:follower])
    UserRelationshipsController.destroy_relationship(user, follower)

    redirect_to :controller => "users", :action => :show, :id => user
  end

  def self.create_relationship(user, follower)
    if user.followers.exists?(follower)
      return
    end

    user.transaction do 
      user.update_attributes(:follower_count => user.follower_count.next)
      user.update_attributes(:version => user.version.next)
      follower.update_attributes(:followee_count => follower.followee_count.next)
      follower.update_attributes(:version => follower.version.next)
      UserRelationship.create(:user => user, :follower => follower, :type => 0, :time => Time.now)
    end
  end

  def self.destroy_relationship(user, follower)
    if !user.followers.exists?(follower)
      return
    end

    user.transaction do 
      user.update_attributes(:follower_count => (user.follower_count-1) )
      user.update_attributes(:version => user.version.next)
      follower.update_attributes(:followee_count => (follower.followee_count-1) )
      follower.update_attributes(:version => follower.version.next)
      user.followers.delete(follower)
    end
  end
  
end
