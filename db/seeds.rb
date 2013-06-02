# -*- coding: utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

# encoding: utf-8

#====================== clear the database ==================== 
TvGroup.delete_all
TvStation.delete_all
TvProgram.delete_all
TvGroupship.delete_all
TvProgramship.delete_all
User.delete_all
Discuss.delete_all
UserRelationship.delete_all
DiscussRelationship.delete_all
DiscussProgramship.delete_all

#====================== create the test data ==================== 
# for user
user_ning = User.create(:name => "xiaoningyb", :password => "123456", :email => "xiaoningyb@gmail.com")
user_bill = User.create(:name => "bill_tang", :password => "123456", :email => "bill.tang@nebutown.com")
user_sun = User.create(:name => "孙大发", :password => "123456", :email => "2358340741@qq.com")

UserRelationshipsController.create_relationship(user_ning, user_bill)
UserRelationshipsController.create_relationship(user_bill, user_ning)
UserRelationshipsController.create_relationship(user_bill, user_sun)
UserRelationshipsController.create_relationship(user_ning, user_sun)

# Create Default Group 
cctv = TvGroup.create(:name => "中国中央电视台", :en_name => "cctv", :description => "中国中央电视频道")
local_tv = TvGroup.create(:name => "卫星电视台", :en_name => "local_tv", :description => "各级省市卫星电视台")
local_tv = TvGroup.create(:name => "地方电视台", :en_name => "city_tv", :description => "各级市电视台")
digit_tv = TvGroup.create(:name => "数字电视台", :en_name => "digit_tv", :description => "数字电视台")
sports_tv = TvGroup.create(:name => "体育电视台", :en_name => "sports_tv", :description => "体育电视台")
movie_tv = TvGroup.create(:name => "电影电视台", :en_name => "movie_tv", :description => "电影电视台")
oversea_tv = TvGroup.create(:name => "海外电视台", :en_name => "oversea_tv", :description => "海外电视台")
hmt_tv = TvGroup.create(:name => "港澳台电视台", :en_name => "hmt_tv", :description => "香港，澳门，台湾电视台")


#test 

cctv1 = TvStation.create(:name => "cctv1", :en_name =>"cctv1", :description => "中国中央电视1台")
cctv.tv_stations << cctv1

group = ProgramGroup.create(:name => "新闻30分", :description => "新闻30分", :group_type => 1)
tv = TvProgram.create(:name => "新闻30分(20130601)", :description => "新闻30分", :group_type => 1, :program_group => group )
TvProgramship.create(:tv_station => cctv1, :tv_program => tv, :begin_time => Time.now, :end_time =>  Time.now + 1 * 3600)
