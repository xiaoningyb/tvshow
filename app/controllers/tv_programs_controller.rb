class TvProgramsController < ApplicationController
  #before_filter :authenticate_user!, :except => [:index, :show]

  #show index page
  def index
    @programs = TvProgram.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @programs.to_xml }
      format.json { render :json => @programs.to_json }
    end
  end

  #new tv program, it will be deprecated
  def new
    @program = TvProgram.new
  end
  
  #new tv program using POST method
  def create
    @program = TvProgram.new(params[:program])
    @program.save
    
    redirect_to :action => :index
  end

  def edit
    @program = TvProgram.find(params[:program])
    @program.transaction do 
      @program.update_attributes(:name => params[:name])
      @program.update_attributes(:description => params[:description])
    end
    
    redirect_to :action => :index
  end

  #show tv program info
  def show
    if (params[:cmd] != nil) && (params[:cmd] == "detail")
      show_detail(params)
    elsif ((params[:cmd] != nil) && (params[:cmd] == "discuss") && (params[:from] != nil) && (params[:to] != nil))
      show_discusses(params)
    else
      show_simple(params)
    end
  end

  #show simple tv info
  def show_simple(params)
    @program = TvProgram.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @program.to_xml }
      format.json { render :json => @program.to_json }
    end
  end

  #show detail tv info
  def show_detail(params)
    @program = TvProgram.find(params[:id])
    program_format = format_detail_json(@program, @program.discusses)

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => program_format.to_xml }
      format.json { render :json => program_format.to_json}
    end
  end

  #show detail tv info
  def show_discusses(params)
    @program = TvProgram.find(params[:id])
    discusses_format = format_discusses_json(@program.discusses[params[:from].to_i .. params[:to].to_i])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => discusses_format.to_xml }
      format.json { render :json => discusses_format.to_json}
    end
  end

  #edit tv group, it will be deprecated
  def edit
    @program = TvProgram.find(params[:id])
  end

  #update tv group using PUT method
  def update
    @program = TvProgram.find(params[:id])
    @program.update_attributes(params[:program])
  
    redirect_to :action => :show, :id => @program
  end

  #delete tv group using DELETE method
  def destroy
    @program = TvProgram.find(params[:id])
    @program.destroy
    
    redirect_to :action => :index
  end

  #format json output function
  def format_detail_json(program, discusses)   
    program[:latest_discusses] = []
    discusses.sort!{|x, y| y.time <=> x.time}
    discusses.each do |discuss|
      discuss[:user_name] = discuss.user.name
      discuss[:user_img] = discuss.user.image
      program[:latest_discusses] << discuss      
    end    

    return program
  end

  #format json output function
  def format_discusses_json(discusses)    
    discusses_format = []
    discusses.sort!{|x, y| y.time <=> x.time}
    discusses.each do |discuss|
      discuss[:user_name] = discuss.user.name
      discuss[:user_img] = discuss.user.image
      discuss_format = discuss.to_json
      discusses_format << discuss_format
    end
    return discusses_format
  end

end
