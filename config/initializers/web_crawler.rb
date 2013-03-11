require 'rubygems'
require 'rufus/scheduler'  

scheduler = Rufus::Scheduler.start_new
#CrawlerInfo.start_crawl

scheduler.every '4d', :first_in => '10m' do
  CrawlerInfo.start_crawl
end
