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
local_tv = TvGroup.create(:name => "地方电视台", :en_name => "local_tv", :description => "各级省市电视台")
hmt_tv = TvGroup.create(:name => "港澳台电视台", :en_name => "hmt_tv", :description => "香港，澳门，台湾电视台")
oversea_tv = TvGroup.create(:name => "海外电视台", :en_name => "oversea_tv", :description => "海外电视台")
sports_tv = TvGroup.create(:name => "体育电视台", :en_name => "sports_tv", :description => "体育电视台")
movie_tv = TvGroup.create(:name => "电影电视台", :en_name => "movie_tv", :description => "电影电视台")
internet_tv = TvGroup.create(:name => "网络电视台", :en_name => "internet_tv", :description => "网络电视台")
