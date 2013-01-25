class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :name, :address, :age, :id_card, :image,  :qq, :telephone, :version, :weibo, :discuss_count, :followee_count, :follower_count, :msg_count

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
