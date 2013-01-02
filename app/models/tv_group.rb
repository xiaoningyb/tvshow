class TvGroup < ActiveRecord::Base
  attr_accessible :description, :image, :name
  has_many :tv_groupships, :dependent => :destroy
  has_many :tv_stations, :through => :tv_groupships, :uniq => true
end
