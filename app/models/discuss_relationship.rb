class DiscussRelationship < ActiveRecord::Base
  attr_accessible :src_id, :quote_id, :type, :time

  belongs_to :discuss

  validates_presence_of :src_id
  validates_presence_of :quote_id
end
