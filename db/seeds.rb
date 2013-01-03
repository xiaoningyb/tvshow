# -*- coding: utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

#====================== clear the database ==================== 
TvGroup.delete_all
TvStation.delete_all
TvProgram.delete_all

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

# for local
sport = TvGroup.create(:name => "体育频道", :description => "体育相关频道")

sport.tv_stations << wxsport
sport.tv_stations << gdsport


