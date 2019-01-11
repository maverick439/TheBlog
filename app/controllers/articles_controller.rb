class ArticlesController < ApplicationController
	skip_before_action :verify_authenticity_token
	#skip_after_action :verify_authenticity_token  
	def new
  		@article = Article.new
 	end

 	def create
  		#render plain: params[:article].inspect
  		# @article = Article.new(article_params)
  		@article = current_user.articles.new(article_params)
  		if @article.save!
   			flash[:notice] = "Article was successfully created"
   			redirect_to article_path(@article)
   			#redirect_to @article
  		else
   			render 'new'
  		end
 	end

 	def show
  		@article = Article.find(params[:id])
  		@comment = Comment.new
		@comment.article_id = @article.id
 	end

 	def edit
 		@article = Article.find(params[:id])
 		unless current_user == @article.user
 			redirect_to(@article, notice: "You are not authorized to edit it") 
 			flash[:error] = "You are not authorized to edit it"
 			return
 		end
	end
	
	def update
		@article = Article.find(params[:id])
  			if @article.update(article_params)
   				flash[:notice] = "Article was updated"
   				redirect_to article_path(@article)
  		else
   			flash[:notice] = "Article was not updated"
   			render 'edit'
  		end
    end

 	def destroy
  		@article = Article.find(params[:id])
  		if current_user == @article.user
	  		@article.destroy
  			flash[:notice] = "Article was deleted"
  			redirect_to articles_path
  		else
  			return
  		end
 	end

 	def index
  		@articles = Article.all
  		@user = current_user
 	end

	private
  		def article_params
   			params.require(:article).permit(:title, :description)
  		end

end
