class TvProgram < ActiveRecord::Base
  attr_accessible :description, :episode, :image, :key_word, :name
end
