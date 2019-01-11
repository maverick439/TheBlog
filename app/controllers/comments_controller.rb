class CommentsController < ApplicationController
  #before_action :authenticate_user!, except: [:index]
  #before_action :find_article!

  def index
    @comment = @article.comments.order(created_at: :desc)
  end

  def create
    @comment = Comment.new(comment_params)
    @article = Article.find(params[:article_id])
  	@comment.article_id = params[:article_id]
  	@comment.user_id = current_user.id
  	@comment.save

  	respond_to do |format|
  		format.html {redirect_to article_path(@comment.article)}
  		format.js
  	end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    if @comment.user_id == current_user.id
        @comment.destroy
    else
        flash[:notice] = "Cannot Delete"
    end
    respond_to do |format|
      format.html {redirect_to article_path(@article)}
      format.js
    end
  end

#  private

#  def find_article!
#    @article = Article.find_by_slug!(params[:article_slug])
#  end

  private

 	def comment_params
  		params.require(:comment).permit(:description,:article_id,:user_id)
	end
end