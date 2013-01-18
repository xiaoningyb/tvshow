class DiscussRelationship < ActiveRecord::Base
  attr_accessible :src_id, :quote_id, :type, :time, :src, :quote

  #relationship between discuss <-> discuss
  belongs_to :src, :class_name => "Discuss"
  belongs_to :quote, :class_name => "Discuss"

  validates_presence_of :src_id
  validates_presence_of :quote_id
end
