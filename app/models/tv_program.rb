class TvProgram < ActiveRecord::Base
  attr_accessible :description, :episode, :image, :key_word, :name

  #for relationship with tv_station
  has_many :tv_programships, :dependent => :destroy
  has_many :tv_stations, :through => :tv_programships, :uniq => true
end
