class User < ActiveRecord::Base
  attr_accessible :address, :age, :backup_email, :discuss_count, :email, :followee_count, :follower_count, :id_card, :image, :msg_count, :name, :password, :qq, :telephone, :version, :weibo

  #for relationship with user  
  has_many :follower_relationships, :class_name => "UserRelationship"
  has_many :followers, :through => :follower_relationships, :source => :follower, :uniq => true

  has_many :followee_relationships, :class_name => "UserRelationship", :foreign_key => "follower_id"
  has_many :followees, :through => :followee_relationships, :source => :user, :uniq => true  

  def get_followees   
    return self.followees      
  end

  def get_followers
    return self.followers
  end

end
