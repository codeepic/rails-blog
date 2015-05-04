class CommentsController < ApplicationController
	before_filter :load_article, :except => :destroy
  before_filter :authenticate, :only => :destroy

  def create
    @comment = @article.comments.new(comment_params)
    if @comment.save
      respond_to do |format|
        format.html { redirect_to @article, notice: 'Thanks for the comment'}
        format.js #since no code is added here, rails looks for
        #a template named after the view, looking for create.js.erb
      end
    else
    	respond_to do |format|
        format.html { redirect_to @article, alert: 'Unable to add comment'}
        format.js {render 'fail_create.js.erb'}
      end
    end
  end

  def destroy
    @article = current_user.articles.find(params[:article_id])

    @comment = @article.comments.find(params[:id])

    @comment.destroy
    
    respond_to do |format|
      format.html {redirect_to @article, notice: 'Commente removed'}
      format.js # will point to destroy.js.erb
    end

  end

	private
	def load_article
    @article = Article.find(params[:article_id])
	end

	def comment_params
    params.require(:comment).permit(:name, :email, :body)
	end
end
