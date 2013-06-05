class UserCheckinshipsController < ApplicationController

  def create
    if params[:tv_program] != nil
      create_tv_program(params)
    elsif params[:program_group] != nil
      create_program_group(params)
    else
      return
    end
  end

  def create_tv_program(params)
    user = User.find(params[:user])
    program = TvProgram.find(params[:tv_program])
    if (params["_method"] != nil) && (params["_method"] == "delete")
      UserCheckinshipsController.destroy_tv_program_relationship(user, program)
    else
      UserCheckinshipsController.create_tv_program_relationship(user, program)
    end
    redirect_to :controller => "tv_programs", :action => :show, :id => program
  end

  def create_program_group(params)
    user = User.find(params[:user])
    program = ProgramGroup.find(params[:program_group])
    if (params["_method"] != nil) && (params["_method"] == "delete")
      UserCheckinshipsController.destroy_program_group_relationship(user, program)
    else
      UserCheckinshipsController.create_program_group_relationship(user, program)
    end
    redirect_to :controller => "program_groups", :action => :show, :id => program
  end

  def self.create_tv_program_relationship(user, program)
    if user == nil || program == nil || user.checkin_tv_programs.exists?(program)
      return
    end

    user.transaction do 
      user.update_attributes(:checkin_count => user.checkin_count.next)
      user.update_attributes(:version => user.version.next)
      program.update_attributes(:checkin_count => program.checkin_count.next)
      UserCheckinship.create(:user => user, :program => program, :time => Time.now)
    end
  end

  def self.create_program_group_relationship(user, program)
    if user == nil || program == nil || user.checkin_program_groups.exists?(program)
      return
    end

    user.transaction do 
      user.update_attributes(:checkin_count => user.checkin_count.next)
      user.update_attributes(:version => user.version.next)
      program.update_attributes(:checkin_count => program.checkin_count.next)
      UserCheckinship.create(:user => user, :program => program, :time => Time.now)
    end
  end

  def destroy
    user = User.find(params[:user])
    if params[:tv_program] != nil
      program = TvProgram.find(params[:tv_program])
      destory_tv_program_relationship(user, program)
      redirect_to :controller => "tv_programs", :action => :show, :id => program
    elsif params[:program_group] != nil
      program = ProgramGroup.find(params[:program_group])
      destory_program_group_relationship(user, program)
      redirect_to :controller => "program_groups", :action => :show, :id => program
    else
      return
    end    
  end

  def destory_tv_program_relationship(user, program)
    if user == nil || program == nil || !user.checkin_tv_programs.exists?(program)
      return
    end

    user.transaction do 
      user.update_attributes(:checkin_count => (user.checkin_count-1) )
      user.update_attributes(:version => user.version.next)
      program.update_attributes(:checkin_count => (program.checkin_count-1) )  
      user.checkin_tv_programs.delete(program)
    end
  end

  def destory_program_group_relationship(user, program)
    if user == nil || program == nil || !user.checkin_program_groups.exists?(program)
      return
    end

    user.transaction do 
      user.update_attributes(:checkin_count => (user.checkin_count-1) )
      user.update_attributes(:version => user.version.next)
      program.update_attributes(:checkin_count => (program.checkin_count-1) )  
      user.checkin_program_groups.delete(program)
    end
  end
  
end
