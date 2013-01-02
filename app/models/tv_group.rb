class TvGroup < ActiveRecord::Base
  attr_accessible :description, :image, :name
  has_many :tv_groupships
  has_many :tv_stations, :through => :tv_groupships
end
