class ArticlesController < ApplicationController
  include ArticlesHelper
  def index
    @articles = Article.latest
    @articles = @articles.by_language(params[:language]) if params[:language].present?
    @articles = @articles.includes(:publisher)
  end
end
