class CommentsController < ApplicationController
    def new
      @comment = Comment.new
      @user = current_user
    end
  
    def create
      user = current_user
      post = Post.find(params[:id] || params[:post_id])
      comment = Comment.new(comment_params)
      comment.author = user
      comment.post = post
      if comment.save
        redirect_to user_post_url(id: post.id)
      else
        redirect_to new_user_post_comment_url(post_id: post.id, user_id: user.id)
      end
    end
  
    def comment_params
      params.require(:comment).permit(:text)
    end
  end