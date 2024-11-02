class FetchArticlesJob < ApplicationJob
  queue_as :default

  def perform
    Publisher.find_each do |publisher|
      articles = FeedParserService.parse_feed_for_publisher(publisher)

      articles.each do |article_data|
        article = publisher.articles.find_or_initialize_by(original_url: article_data[:original_url])

        next if article.persisted? # Skip if article already exists

        article.assign_attributes(
          title: article_data[:title],
          published_at: article_data[:published_at],
          image_url: article_data[:image_url]
        )

        article.save
      end
    end
  end
end
