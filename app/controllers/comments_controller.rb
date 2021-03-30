class CommentsController < ApplicationController

	http_basic_authenticate_with name: "hoangtoni", password: "123qwe", only: :destroy

	def create
		@article = Article.find(params[:article_id])
		@comment = @article.comments.create(comment_params)
		redirect_to article_path(@article)
	end

	def destroy
		# @article = Article.find(params[:article_id])
		@comment = Comment.find(params[:id])
		@article = @comment.article
		@comment.destroy

		redirect_to @article
	end

	private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
