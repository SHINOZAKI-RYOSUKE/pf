class CommentsController < ApplicationController

  before_action :authenticate_user!


  def create
    @content = Content.find(params[:content_id])

    @comments = Comment.all
    comment = current_user.comments.new(comment_params)
    comment.content_id = @content.id
    comment.save
    
    # ここから
    comment.content.create_notification_comment!(current_user, comment.id)
    # ここまで
    
  end

  def destroy
    @content = Content.find(params[:content_id])

    @comments = Comment.all
    content_comment = @content.comments.find(params[:id])
    content_comment.destroy
  end



  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
