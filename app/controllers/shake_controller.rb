class ShakeController < ApplicationController

  #show user info
  def index
    if (params[:cmd] != nil) && (params[:cmd] == "hot_watch")
      index_hot_watch(params)
    elsif ((params[:cmd] != nil) && (params[:cmd] == "hot_discuss"))
      index_hot_discuss(params)
    elsif ((params[:cmd] != nil) && (params[:cmd] == "hot_activity"))
      index_hot_activity(params)
    elsif ((params[:cmd] != nil) && (params[:cmd] == "hot_checkin"))
      index_hot_checkin(params)
    elsif ((params[:cmd] != nil) && (params[:cmd] == "detail"))
      index_detail(params)
    else
      index_simple(params)
    end
  end

  #show hot watch program
  def index_hot_watch(params)
    @programs = TvProgram.all
    @programs.sort!{|x, y| y.watch_count <=> x.watch_count}
    if((params[:size] != nil))
       @programs = @programs[0 .. (params[:size].to_i-1)]    
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @programs.to_xml }
      format.json { render :json => @programs.to_json }
    end
  end

  #show hot discuss program
  def index_hot_discuss(params)
    @programs = TvProgram.all
    @programs.sort!{|x, y| y.discuss_count <=> x.discuss_count}
    if((params[:size] != nil))
       @programs = @programs[0 .. (params[:size].to_i-1)]
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @programs.to_xml }
      format.json { render :json => @programs.to_json }
    end
  end

  #show hot activity program
  def index_hot_activity(params)
  end

  #show hot activity program
  def index_hot_checkin(params)
    @programs = TvProgram.all
    @programs.sort!{|x, y| y.checkin_count <=> x.checkin_count}
    if((params[:size] != nil))
       @programs = @programs[0 .. (params[:size].to_i-1)]
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @programs.to_xml }
      format.json { render :json => @programs.to_json }
    end
  end

  #show detail
  def index_detail(params)
  end

  #show simple
  def index_simple(params)
  end

end
