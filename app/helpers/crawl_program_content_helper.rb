module CrawlProgramContentHelper
  
  class Baike
    BAIKE_BASE_URL = 'http://wapbaike.baidu.com'
    def start_crawl_keyword(keyword)
      #create agent
      @agent = Mechanize.new
      @result = {:description => "", :image_url => ""}

      #fill agent info
      @agent.request_headers['Referer'] = BAIKE_BASE_URL
      @agent.user_agent_alias = 'Mac Safari'

      #get search url
      url = BAIKE_BASE_URL + '/search?word=' + keyword
      url = URI::escape(url)
      
      #get search result
      page = @agent.get(url)

      #find final_url
      page.search('meta').each do |content|
        if (content['http-equiv'] != nil) && content['http-equiv'] == 'Refresh' && (content['content'] != nil) 
          final_url = /\d+;URL=/.match(content['content']).post_match
          if not final_url.empty?
            crawl_page(BAIKE_BASE_URL + final_url)
          end
        end
      end

      puts "content = " + @result[:description]
      puts "image_url = " + @result[:image_url]

      return @result
    end

    def crawl_page(url)
      #get page result
      page = @agent.get(url)

      #get baike card
      page.search('html/body/div/div').each do |classic|
        if(classic['class'] == 'card')
          parse_baike_card(classic)
        end
      end
    end

    def parse_baike_card(content)
      content.search('p').each do |paragraph|
        @result[:description] += paragraph.text
      end
      @result[:description].gsub!(' ','')
      @result[:description].gsub!(/\t/, '')

      content.search('div').each do |paragraph|
        if paragraph['class'] == "img-box"
          @result[:image_url] = paragraph.search('a/img')[0]['src']
        end
      end
    end
    
  end

end
