class Discuss < ActiveRecord::Base
  attr_accessible :topic, :user_id, :discuss_type, :content, :time, :location, :image, :like, :dislike, :neutrality, :src_id, :quote_count, :quotes, :srcs, :tv_program

  #for relationship with discuss
  has_many :quote_relationships, :class_name => "DiscussRelationship", :foreign_key => "src_id"
  has_many :quotes, :through => :quote_relationships, :source => :quote, :uniq => true

  has_many :src_relationships, :class_name => "DiscussRelationship"
  has_many :srcs, :through => :src_relationships, :source => :src, :uniq => true


  #for relationship with tv_program
  belongs_to :tv_program
end
