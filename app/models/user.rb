class User < ActiveRecord::Base
  attr_accessible :address, :age, :backup_email, :discuss_count, :email, :fans_count, :follow_count, :id_card, :image, :msg_count, :name, :password, :qq, :telephone, :version, :weibo
end
