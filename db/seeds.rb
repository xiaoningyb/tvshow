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

#add the program
0.step(24, 1).to_a.each do |i|
  #for cctv1
  xwlb = TvProgram.create(:name => "新闻联播(" + i.to_s + ")", :description => "新闻联播: 每天晚上7点")
  TvProgramship.create(:tv_station => cctv1, :tv_program => xwlb, :begin => Time.now + i * 3600, :end =>  Time.now + (i + 1) * 3600, 
                       :duration => 60, :is_alive => true)

  #for cctv2
  jjbxs = TvProgram.create(:name => "经济半小时("+ i.to_s + ")", :description => "经济半小时")
  TvProgramship.create(:tv_station => cctv2, :tv_program => jjbxs, :begin => Time.now + i * 3600, :end =>  Time.now + (i + 1) * 3600,
                       :duration => 60, :is_alive => true)

  #for cctv3
  wyscw = TvProgram.create(:name => "我要上春晚(" + i.to_s + ")", :description => "我要上春晚")
  TvProgramship.create(:tv_station => cctv3, :tv_program => wyscw, :begin => Time.now + i * 3600, :end =>  Time.now + (i + 1) * 3600,
                       :duration => 60, :is_alive => true)

  #for cctv4 
  gjxw = TvProgram.create(:name => "国际新闻(" + i.to_s + ")", :description => "国际新闻")
  TvProgramship.create(:tv_station => cctv4, :tv_program => gjxw, :begin => Time.now + i * 3600, :end =>  Time.now + (i + 1) * 3600,
                       :duration => 60, :is_alive => true)

  #for cctv6
  bxjg = TvProgram.create(:name => "变形金刚3", :description => "电影")
  TvProgramship.create(:tv_station => cctv6, :tv_program => bxjg, :begin => Time.now + i * 3600, :end =>  Time.now + (i + 1) * 3600,
                       :duration => 60, :is_alive => true)

  #for cctv5
  heat_bull = TvProgram.create(:name => "NBA常规赛:热火vs公牛(" + i.to_s + ")", :description => "北京时间2013年1月5日常规赛，早上9点至11点")
  heat_bull_re = TvProgram.create(:name => "NBA常规赛重播:热火vs公牛(" + i.to_s + ")", :description => "北京时间2013年1月5日常规赛，早上9点至11点")
  spurs_knicks = TvProgram.create(:name => "NBA常规赛:马刺vs尼克斯(" + i.to_s + ")", :description => "北京时间2013年1月5日常规赛，早上10点至12点")
  TvProgramship.create(:tv_station => cctv5, :tv_program => heat_bull, :begin => Time.now + i * 1200, :end =>  Time.now + (i + 1) *1200, 
                       :duration => 20, :is_alive => true)
  TvProgramship.create(:tv_station => cctv5, :tv_program => heat_bull_re, :begin => Time.now + (i+1) * 1200, :end =>  Time.now + (i + 2) *1200, 
                       :duration => 20, :is_alive => false)
  TvProgramship.create(:tv_station => cctv5, :tv_program => spurs_knicks, :begin => Time.now + (i+2) * 1200, :end =>  Time.now + (i + 3) *1200, 
                       :duration => 20, :is_alive => false)
end


# for local 
local = TvGroup.create(:name => "地方电视台", :description => "各级省市电视台")

hntv = TvStation.create(:name => "湖南卫视", :description => "湖南省级卫星电视台")
zjtv = TvStation.create(:name => "浙江卫视", :description => "浙江省级卫星电视台")
jstv = TvStation.create(:name => "江苏卫视", :description => "江苏省级卫星电视台")
smgtv = TvStation.create(:name => "东方卫视", :description => "上海市卫星电视台")
wxsport = TvStation.create(:name => "五星体育", :description => "上海文广所属体育体育频道")
gdsport = TvStation.create(:name => "广东体育", :description => "广东省级电视台所属体育频道")

local.tv_stations << hntv
local.tv_stations << zjtv
local.tv_stations << jstv
local.tv_stations << smgtv
local.tv_stations << wxsport
local.tv_stations << gdsport

#add the program
0.step(24, 1).to_a.each do |i|
  #for hntv
  klns = TvProgram.create(:name => "快乐女生(" + i.to_s + ")", :description => "选秀比赛")
  TvProgramship.create(:tv_station => hntv, :tv_program => klns, :begin => Time.now + i * 3600, :end =>  Time.now + (i + 1) * 3600, 
                       :duration => 60, :is_alive => true)

  #for hntv
  zghsy = TvProgram.create(:name => "中国好声音(" + i.to_s + ")", :description => "选秀比赛")
  TvProgramship.create(:tv_station => zjtv , :tv_program => zghsy, :begin => Time.now + i * 3600, :end =>  Time.now + (i + 1) * 3600, 
                       :duration => 60, :is_alive => true)

  #for jstv
  fcwr = TvProgram.create(:name => "非诚勿扰(" + i.to_s + ")", :description => "相亲节目")
  TvProgramship.create(:tv_station => jstv , :tv_program => fcwr, :begin => Time.now + i * 3600, :end =>  Time.now + (i + 1) * 3600, 
                       :duration => 60, :is_alive => true)

  #for smgtv
  zgdrx = TvProgram.create(:name => "中国达人秀(" + i.to_s + ")", :description => "比赛节目")
  TvProgramship.create(:tv_station => smgtv, :tv_program => zgdrx, :begin => Time.now + i * 3600, :end =>  Time.now + (i + 1) * 3600, 
                       :duration => 60, :is_alive => true)  
end

# for sports
sport = TvGroup.create(:name => "体育频道", :description => "体育相关频道")

sport.tv_stations << cctv5
sport.tv_stations << wxsport
sport.tv_stations << gdsport

#add the program
0.step(24, 1).to_a.each do |i|
  #for wxsport
  aus_tennis = TvProgram.create(:name => "澳大利亚网球比赛(" + i.to_s + ")", :description => "网球比赛")
  TvProgramship.create(:tv_station => wxsport, :tv_program => aus_tennis, :begin => Time.now + i * 3600, :end =>  Time.now + (i + 1) * 3600, 
                       :duration => 60, :is_alive => true)
  #for hntv
  eng_football = TvProgram.create(:name => "西班牙足球联赛(" + i.to_s + ")", :description => "足球比赛")
  TvProgramship.create(:tv_station => gdsport , :tv_program => eng_football, :begin => Time.now + i * 3600, :end =>  Time.now + (i + 1) * 3600, 
                       :duration => 60, :is_alive => true)
end

# for user
user_ning = User.create(:name => "xiaoningyb", :password => "123456", :email => "xiaoningyb@gmail.com")
user_bill = User.create(:name => "bill_tang", :password => "123456", :email => "bill.tang@nebutown.com")
user_sun = User.create(:name => "孙大发", :password => "123456", :email => "2358340741@qq.com")

UserRelationshipsController.create_relationship(user_ning, user_bill)
UserRelationshipsController.create_relationship(user_bill, user_ning)
UserRelationshipsController.create_relationship(user_bill, user_sun)
UserRelationshipsController.create_relationship(user_ning, user_sun)

# for discuss


