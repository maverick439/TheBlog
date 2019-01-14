class LikesController < ApplicationController
	skip_before_action :verify_authenticity_token
	before_action :find_like, only: [:destroy]
	before_action :find_article

	def create
		if already_liked?
    		flash[:notice] = "You can't like more than once"
    		#window.alert("You can't like more than once");
    		render(
        		html: "<script>alert('Liked Already')</script>".html_safe,
        		layout: 'application'
      		)

  		else
			@article.likes.create(user_id: current_user.id)
		end	
		redirect_to article_path(@article)
	end

	def destroy
  		if !(already_liked?)
    		flash[:notice] = "Cannot unlike"
  		else
    		@like.destroy
  		end
  		redirect_to article_path(@article)
end
	private
	def find_like
   		@like = @article.likes.find(params[:id])
	end
	def find_article
		@article = Article.find(params[:article_id])
	end

	def already_liked?
		Like.where(user_id: current_user.id, article_id: params[:article_id]).exists?
	end
end
