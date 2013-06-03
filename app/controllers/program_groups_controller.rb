class ProgramGroupsController < ApplicationController

  #show tv program info
  def show

    @program_group = ProgramGroup.find(params[:id])
    @program_group[:tv_programs] = @program_group.tv_programs

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @program_group.to_xml }
      format.json { render :json => @program_group.to_json }
    end
  end

end
