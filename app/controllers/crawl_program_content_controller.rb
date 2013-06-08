class CrawlProgramContentController < ApplicationController
    
  #new page for crawling infomation about tv_program
  def create
    if params[:tv_program] != nil
      @program = TvProgram.find(params[:tv_program][:id])
      @program.transaction do 
        @program.update_attributes(:name => params[:tv_program][:name])
        @program.update_attributes(:description => params[:tv_program][:description])
        @program.update_attributes(:key_word => params[:tv_program][:key_word]) if not params[:tv_program][:key_word].empty?
        @program.update_attributes(:image => params[:tv_program][:image])
      end
      redirect_to :controller=>"tv_programs", :action => :show, :id => @program
    elsif params[:program_group] != nil
      @program = ProgramGroup.find(params[:program_group][:id])
      @program.transaction do 
        @program.update_attributes(:name => params[:program_group][:name])
        @program.update_attributes(:description => params[:program_group][:description])
        @program.update_attributes(:key_word => params[:program_group][:key_word]) if not params[:program_group][:key_word].empty?
        @program.update_attributes(:image => params[:program_group][:image])
      end
      redirect_to :controller=>"program_groups", :action => :show, :id => @program
    end
  end

  #new page for crawl info
  def new
    @user = User.find(params[:user])
    if params[:program_type].to_i == 0
      @program = TvProgram.find(params[:program])
    elsif params[:program_type].to_i == 1
      @program = ProgramGroup.find(params[:program])
    end

    crawler = CrawlProgramContentHelper::Baike.new

    if @program.key_word != nil and not @program.key_word.empty?
      result = crawler.start_crawl_keyword(@program.key_word)
    else
      result = crawler.start_crawl_keyword(@program.name)
    end
    
    @program.description = result[:description]
    @program.image = result[:image]

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => program.to_xml }
      format.json { render :json => program.to_json }
    end
  end

end
