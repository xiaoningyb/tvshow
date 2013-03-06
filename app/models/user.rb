class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :token_authenticatable

  before_save :ensure_authentication_token

  # accessible (or protected) attributes
  attr_accessible :email, :password, :password_confirmation, :remember_me, :authentication_token
  attr_accessible :name, :address, :age, :id_card, :image,  :qq, :telephone, :version, :weibo,  :discusses, 
                  :checkin_count, :discuss_count, :watch_count, :followee_count, :follower_count, :msg_count

  #for relationship with user  
  has_many :follower_relationships, :class_name => "UserRelationship"
  has_many :followers, :through => :follower_relationships, :source => :follower, :uniq => true

  has_many :followee_relationships, :class_name => "UserRelationship", :foreign_key => "follower_id"
  has_many :followees, :through => :followee_relationships, :source => :user, :uniq => true  

  #for watch relation with tv_program
  has_many :user_checkinships, :dependent => :destroy
  has_many :checkin_programs, :through => :user_checkinships, :source => :tv_program,  :uniq => true

  #for checkin relation with tv_program
  has_many :user_programships, :dependent => :destroy
  has_many :tv_programs, :through => :user_programships, :uniq => true

  #for relationship with discuss
  has_many :discusses

  def get_followees   
    return self.followees      
  end

  def get_followers
    return self.followers
  end

  def has_followee(user)
    return self.followees.include?(user)
  end

  def has_follower(user)
    return self.followers.include?(user)
  end

  def has_watch(program)
    return self.tv_programs.include?(program)
  end

  def get_watch_programs
    return self.tv_programs
  end

  def has_checkin(program)
    return self.checkin_programs.include?(program)
  end

  def get_checkin_programs
    return self.checkin_programs
  end

  def get_discusses
    return self.discusses
  end
  
end
