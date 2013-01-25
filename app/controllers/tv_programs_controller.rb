class TvProgramsController < ApplicationController
  before_filter :authenticate_user!

  #show index page
  def index
    @programs = TvProgram.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @programs.to_xml }
      format.json { render :json => @programs.to_json }
    end
  end

  #new tv station, it will be deprecated
  def new
    @program = TvProgram.new
  end
  
  #new tv station using POST method
  def create
    @program = TvProgram.new(params[:program])
    @program.save
    
    redirect_to :action => :index
  end

  #show tv group info
  def show
    @program = TvProgram.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @program.to_xml }
      format.json { render :json => @program.to_json }
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
end
