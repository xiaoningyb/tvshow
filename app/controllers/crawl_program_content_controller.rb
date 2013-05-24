class CrawlProgramContentController < ApplicationController
    
  #new page for crawling infomation about tv_program
  def create
    @program = TvProgram.find(params[:tv_program][:id])
    @program.transaction do 
      @program.update_attributes(:name => params[:tv_program][:name])
      @program.update_attributes(:description => params[:tv_program][:description])
      @program.update_attributes(:image => params[:tv_program][:image])
    end

    redirect_to :controller=>"tv_programs", :action => :show, :id => @program
  end

  #new page for crawl info
  def new
    @user = User.find(params[:user])
    @program = TvProgram.find(params[:program])

    crawler = CrawlProgramContentHelper::Baike.new

    result = crawler.start_crawl_keyword(@program.name)
    
    @program.description = result[:description]
    @program.image = result[:image]

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => program.to_xml }
      format.json { render :json => program.to_json }
    end
  end

end
