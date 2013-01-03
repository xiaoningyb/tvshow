class TvStation < ActiveRecord::Base
  attr_accessible :description, :image, :name
  #for relationship with tv_group
  has_many :tv_groupships, :dependent => :destroy
  has_many :tv_groups, :through => :tv_groupships, :uniq => true
  #for relationship with tv_program
  has_many :tv_programships, :dependent => :destroy
  has_many :tv_programs, :through => :tv_programships, :uniq => true
end
