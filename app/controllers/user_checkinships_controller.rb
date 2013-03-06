class UserCheckinshipsController < ApplicationController

  def create
    user = User.find(params[:user])
    program = TvProgram.find(params[:program])
    if (params["_method"] != nil) && (params["_method"] == "delete")
      UserCheckinshipsController.destroy_relationship(user, program)
    else
      UserCheckinshipsController.create_relationship(user, program)
    end

    redirect_to :controller => "tv_programs", :action => :show, :id => program
  end

  def destroy
    user = User.find(params[:user])
    program = TvProgram.find(params[:program])
    UserCheckinshipsController.destroy_relationship(user, program)

    redirect_to :controller => "tv_programs", :action => :show, :id => program
  end

  def self.create_relationship(user, program)
    if user == nil || program == nil || user.checkin_programs.exists?(program)
      return
    end

    user.transaction do 
      user.update_attributes(:checkin_count => user.checkin_count.next)
      user.update_attributes(:version => user.version.next)
      program.update_attributes(:checkin_count => program.checkin_count.next)
      UserCheckinship.create(:user => user, :tv_program => program, :time => Time.now)
    end
  end

  def self.destroy_relationship(user, program)
    if user == nil || program == nil || !user.checkin_programs.exists?(program)
      return
    end

    user.transaction do 
      user.update_attributes(:checkin_count => (user.checkin_count-1) )
      user.update_attributes(:version => user.version.next)
      program.update_attributes(:checkin_count => (program.checkin_count-1) )
      user.checkin_programs.delete(program)
    end
  end

end
