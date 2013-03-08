class DiscussCommentshipsController < ApplicationController

 def create
   user = User.find(params[:user])
   discuss = Discuss.find(params[:discuss])
   type = params[:comment_type].to_i

   if (params["_method"] == nil) 
     DiscussCommentshipsController.create_relationship(user, discuss, type)
   elsif (params["_method"] == "delete")
     comment = DiscussComment.find(params[:discuss_comment])
     DiscussCommentshipsController.destroy_relationship(user, discuss, comment)
   elsif (params["_method"] == "update")
     comment = DiscussComment.find(params[:discuss_comment])
     DiscussCommentshipsController.update_relationship(user, discuss, comment, type)
   end
   
   redirect_to :controller => "discusses", :action => :show, :id => discuss
 end
 
  def destroy
    user = User.find(params[:user])
    comment = DiscussComment.find(params[:discuss_comment])
    discuss = Discuss.find(params[:discuss])
    DiscussCommentshipsController.destroy_relationship(user, discuss, comment)

    redirect_to :controller => "discusses", :action => :show, :id => discuss
  end

  def self.create_relationship(user, discuss, type)
    if user == nil || discuss == nil || user.discuss_comments.exists?(discuss)
      return
    end

    user.transaction do
      if type == 1
        discuss.update_attributes(:like => discuss.like.next)
      elsif type == -1
        discuss.update_attributes(:dislike => discuss.dislike.next)
      else
        discuss.update_attributes(:neutrality => discuss.neutrality.next)
        #for wrong comment type
        type = 0
      end
      user.discuss_comments.create(:user => user, :discuss => discuss, :comment_type => type)
      user.update_attributes(:version => user.version.next)
    end
  end

  def self.update_relationship(user, discuss, comment, type)
    if user == nil || discuss == nil || comment == nil || user.discuss_comments.exists?(discuss)
      return
    end
    user.transaction do
      if comment.comment_type == 1
        discuss.update_attributes(:like => (discuss.like-1) )
      elsif comment.comment_type == -1
        discuss.update_attributes(:dislike => (discuss.dislike-1) )
      elsif comment.comment_type == 0
        discuss.update_attributes(:neutrality => (discuss.neutrality-1) )
      end

      if type == 1
        discuss.update_attributes(:like => discuss.like.next)
      elsif type == -1
        discuss.update_attributes(:dislike => discuss.dislike.next)
      else
        discuss.update_attributes(:neutrality => discuss.neutrality.next)
        #for wrong comment type
        type = 0
      end

      comment.update_attributes(:comment_type => type)
      user.update_attributes(:version => user.version.next)
    end
  end

  def self.destroy_relationship(user, discuss, comment)
    if user == nil || discuss == nil || comment == nil || !user.discuss_comments.exists?(comment)
      return
    end

    user.transaction do 
      if comment.comment_type == 1
        discuss.update_attributes(:like => (discuss.like-1) )
      elsif comment.comment_type == -1
        discuss.update_attributes(:dislike => (discuss.dislike-1) )
      elsif comment.comment_type == 0
        discuss.update_attributes(:neutrality => (discuss.neutrality-1) )
      end

      user.discuss_comments.delete(comment)
      user.update_attributes(:version => user.version.next)
    end

  end

end
