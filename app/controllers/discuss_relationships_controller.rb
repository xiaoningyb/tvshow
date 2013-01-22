class DiscussRelationshipsController < ApplicationController

  def create
    src = User.find(params[:src])
    quote = User.find(params[:quote])
    self.create_relationsip(src, quote)
  end

  def destory
    src = User.find(params[:src])
    quote = User.find(params[:quote])
    self.destory_relationsip(user, quote)
  end

  def self.create_relationship(src, quote, program)
    if src == nil || program == nil
      return
    end

    src.transaction do 
      src.update_attributes(:tv_program => program)     
      program.update_attributes(:discuss_count => program.discuss_count.next)
      if quote != nil
        quote.update_attributes(:tv_program => program)
        src.update_attributes(:quote_count => src.quote_count.next)      
        quote.update_attributes(:discuss_type => 1)
        quote.update_attributes(:src_id => src.id)
        DiscussRelationship.create(:src => src, :quote => quote, :time => Time.now)
      end
    end
  end

  def self.destory_relationship(src, quote, program)
    if src == nil || program == nil
      return
    end

    src.transaction do
      src.update_attributes(:tv_program => nil)
      program.update_attributes(:discuss_count => (program.discuss_count-1) ) 
      if quote != nil
        quote.update_attributes(:tv_program => nil)
        src.update_attributes(:quote_count => (src.quote_count-1) )
        quote.update_attributes(:discuss_type => 0)
        quote.update_attributes(:src_id => nil)
        DiscussRelationship.destory(:src => src, :quote => quote)
      end
    end
  end

end
