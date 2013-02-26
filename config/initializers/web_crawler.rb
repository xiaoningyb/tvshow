require 'rubygems'
require 'rufus/scheduler'  

scheduler = Rufus::Scheduler.start_new

scheduler.every("5s") do
   CrawlerInfo.start_crawl
end
