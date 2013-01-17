class Discuss < ActiveRecord::Base
  attr_accessible :topic, :user_id, :disscuss_type, :content, :time, :location, :image, :like, :dislike, :neutrality, :src_id, :quote_count

  #for relationship with discuss
  has_many :quote_relationships, :class_name => "DiscussRelationship"
  has_many :quotes, :through => :quote_relationships, :source => :quote_id, :uniq => true

end
