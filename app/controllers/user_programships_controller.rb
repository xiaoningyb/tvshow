class UserProgramshipsController < ApplicationController

  def create
    user = User.find(params[:user])
    program = TvProgram.find(params[:program])
    UserProgramshipsController.create_relationship(user, program)

    redirect_to :controller => "tv_programs", :action => :show, :id => program
  end

  def destroy
    user = User.find(params[:user])
    program = TvProgram.find(params[:program])
    UserProgramshipsController.destroy_relationship(user, program)

    redirect_to :controller => "tv_programs", :action => :show, :id => program
  end

  def self.create_relationship(user, program)
    if user == nil || program == nil || user.tv_programs.exists?(program)
      return
    end

    user.transaction do 
      user.update_attributes(:watch_count => user.watch_count.next)
      user.update_attributes(:version => user.version.next)
      program.update_attributes(:watch_count => program.watch_count.next)
      UserProgramship.create(:user => user, :tv_program => program, :type => 0, :time => Time.now)
    end
  end

  def self.destroy_relationship(user, program)
    if user == nil || program == nil || !user.tv_programs.exists?(program)
      return
    end

    user.transaction do 
      user.update_attributes(:watch_count => (user.watch_count-1) )
      user.update_attributes(:version => user.version.next)
      program.update_attributes(:watch_count => (program.watch_count-1) )
      user.tv_programs.delete(program)
    end
  end

end
