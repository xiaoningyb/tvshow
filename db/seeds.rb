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

# for cctv 
cctv = TvGroup.create(:name => "cctv", :description => "中国中央电视台")

cctv1 = TvStation.create(:name => "cctv1", :description => "中国中央电视1台")
cctv2 = TvStation.create(:name => "cctv2", :description => "中国中央电视经济频道")
cctv3 = TvStation.create(:name => "cctv3", :description => "中国中央电视音乐频道")
cctv4 = TvStation.create(:name => "cctv4", :description => "中国中央电视国际频道")
cctv5 = TvStation.create(:name => "cctv5", :description => "中国中央电视体育频道")
cctv6 = TvStation.create(:name => "cctv6", :description => "中国中央电视电影频道")

cctv.tv_stations << cctv1
cctv.tv_stations << cctv2
cctv.tv_stations << cctv3
cctv.tv_stations << cctv4
cctv.tv_stations << cctv5
cctv.tv_stations << cctv6

nba_heat_bull = TvProgram.create(:name => "NBA常规赛:热火vs公牛", :description => "北京时间2013年1月5日常规赛，早上9点至11点")
nba_spurs_knicks = TvProgram.create(:name => "NBA常规赛:马刺vs尼克斯", :description => "北京时间2013年1月5日常规赛，早上10点至12点")

TvProgramship.create(:tv_station => cctv5, :tv_program => nba_heat_bull, :begin => Time.local(2013,1,4,11), :end =>  Time.local(2013,1,4,11), :duration => 120, :is_alive => true)
TvProgramship.create(:tv_station => cctv5, :tv_program => nba_heat_bull, :begin => Time.local(2013,1,4,19), :end =>  Time.local(2013,1,4,21), :duration => 120, :is_alive => false)
TvProgramship.create(:tv_station => cctv5, :tv_program => nba_spurs_knicks, :begin => Time.mktime(2013,1,4,21), :end => Time.mktime(2013,1,4,23), :duration => 120, :is_alive => false)

# for local 
local = TvGroup.create(:name => "地方电视台", :description => "各级省市电视台")

hntv = TvStation.create(:name => "湖南卫视", :description => "湖南省级卫星电视台")
zjtv = TvStation.create(:name => "浙江卫视", :description => "浙江省级卫星电视台")
jstv = TvStation.create(:name => "江苏卫视", :description => "江苏省级卫星电视台")
sgtv = TvStation.create(:name => "东方卫视", :description => "上海市卫星电视台")
wxsport = TvStation.create(:name => "五星体育", :description => "上海文广所属体育体育频道")
gdsport = TvStation.create(:name => "广东体育", :description => "广东省级电视台所属体育频道")

local.tv_stations << hntv
local.tv_stations << zjtv
local.tv_stations << jstv
local.tv_stations << sgtv
local.tv_stations << wxsport
local.tv_stations << gdsport

# for sports
sport = TvGroup.create(:name => "体育频道", :description => "体育相关频道")

sport.tv_stations << cctv5
sport.tv_stations << wxsport
sport.tv_stations << gdsport


TvProgramship.create(:tv_station => wxsport, :tv_program => nba_heat_bull, :begin => Time.mktime(2013,1,4,9), :end => Time.mktime(2013,1,4,11), :duration => 120, :is_alive => true)

TvProgramship.create(:tv_station => gdsport, :tv_program => nba_heat_bull, :begin => Time.mktime(2013,1,4,21), :end => Time.mktime(2013,1,4,23), :duration => 120, :is_alive => false)


# for user

user_ning = User.create(:name => "xiaoningyb", :password => "123456", :email => "xiaoningyb@gmail.com", :msg_count => 0, :discuss_count => 0, :followee_count => 0, :follower_count => 0, :version => 0)

user_bill = User.create(:name => "bill_tang", :password => "123456", :email => "bill.tang@nebutown.com", :msg_count => 0, :discuss_count => 0, :followee_count => 0, :follower_count => 0, :version => 0)

user_sun = User.create(:name => "孙大发", :password => "123456", :email => "2358340741@qq.com", :msg_count => 0, :discuss_count => 0, :followee_count => 0, :follower_count => 0, :version => 0)


UserRelationship.create(:user => user_ning, :follower => user_bill, :type => 0, :time => Time.now)
#user_ning.fans_relationships.build(:follower => user_bill, :type => 0, :time => Time.now)

