class UserRelationship < ActiveRecord::Base
  attr_accessible :follow_id, :time, :type, :user_id
end
