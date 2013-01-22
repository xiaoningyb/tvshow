class TvStationsController < ApplicationController

 #show index page
  def index
    @stations = TvStation.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @stations.to_xml }
      format.json { render :json => @stations.to_json }
    end
  end

  #new tv station, it will be deprecated
  def new
    @station = TvStation.new
  end
  
  #new tv station using POST method
  def create
    create_station_in_group(params)
    
    redirect_to :action => :index
  end

  #show tv group info
  def show
    @station = TvStation.find(params[:id])
    @programs = @station.get_programs()

    @programs_format = self.format_show(@programs)
    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @programs_format.to_xml }
      format.json { render :json => @programs_format.to_json }
    end
  end

  #edit tv group, it will be deprecated
  def edit
    @station = TvStation.find(params[:id])
  end

  #update tv group using PUT method
  def update
    @station = TvStation.find(params[:id])
    @station.update_attributes(params[:station])
  
    redirect_to :action => :show, :id => @station
  end

  #delete tv group using DELETE method
  def destroy
    @station = TvStation.find(params[:id])
    @station.destroy
    
    redirect_to :action => :index
  end

  #format function
  def format_show(programs_info)
    programs_format = []
    programs_info.each do |programship, program|
      program_format = { :program_id => program.id, :name => program.name, :description => program.description, :episode => program.episode, 
                         :image => program.image, :key_word => program.key_word, :begin => programship.begin, :end => programship.end, 
                         :duration => programship.duration, :is_alive => programship.is_alive }
      programs_format << program_format
    end
    return programs_format
  end

  #create the station with group
  def create_station_in_group(params)
    TvStation.transaction do
      @station = TvStation.new(params[:tv_station])
      @station.save      
      if (params[:group] != nil) and (params[:group][:group_id] != nil)
        group = TvGroup.find(params[:group][:group_id])
        if group != nil
          TvGroupship.create(:tv_group => group, :tv_station => @station)
        end
      end
    end
  end  

end
