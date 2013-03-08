class DiscussComment < ActiveRecord::Base
  attr_accessible :content, :discuss_id, :comment_type, :user_id, :discuss, :user

  #for relationship with discuss
  belongs_to :discuss

  #for relationship with user
  belongs_to :user
  
end
