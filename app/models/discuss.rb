class Discuss < ActiveRecord::Base
  attr_accessible :commit_count, :content, :host, :image, :time, :topic, :type
end
