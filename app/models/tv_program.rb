class TvProgram < ActiveRecord::Base
  attr_accessible :description, :episode, :image, :key_word, :name, :watch_count, :discuss_count, :checkin_count, :discusses

  #for relationship with tv_station
  has_many :tv_programships, :dependent => :destroy
  has_many :tv_stations, :through => :tv_programships, :uniq => true

  #for relationship with user
  has_many :user_programships, :dependent => :destroy
  has_many :users, :through => :user_programships, :uniq => true

  #for relationship with discuss
  has_many :discusses
end
