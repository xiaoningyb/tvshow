class DiscussRelationship < ActiveRecord::Base
  attr_accessible :discuss_id, :reply_id, :reply_user_id, :time, :type, :user_id
end
