class ArticlesController < ApplicationController
  include ArticlesHelper
  def index
    @articles = Article.latest
    @articles = @articles.by_language(params[:language]) if params[:language].present?
    @articles = @articles.includes(:publisher)
  end

  def summary
    require "openai"
    article = Article.find(params[:id])
    # TODO - Implement your summary generation logic here
    summary = "This is a summary of the article: #{article.title}"

    render json: { summary: summary }
  end
end
