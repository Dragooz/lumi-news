class Api::V1::ArticlesController < ApplicationController
  # @return [ActiveRecord::Relation<Article>]
  def index
    @articles = Article.latest
    @articles = @articles.by_language(params[:language]) if params[:language].present?
    
    render json: @articles.includes(:publisher).map { |article|
      {
        id: article.id,
        title: article.title,
        published_at: article.published_at,
        publisher: article.publisher.name,
        image_url: article.image_url,
        original_url: article.original_url,
        language: article.publisher.language
      }
    }
  end
end
