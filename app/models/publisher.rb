class Publisher < ApplicationRecord
    has_many :articles
    validates :name, presence: true, uniqueness: true
    validates :feed_url, presence: true
    validates :language, presence: true, inclusion: { in: %w[en ms] }

    PUBLISHER_CONFIGS = {
        "SAYS" => { language: "en", feed_url: "https://says.com/my/rss" },
        "Utusan" => { language: "ms", feed_url: "https://utusan.com.my/feed" },
        "Berita Harian" => { language: "ms", feed_url: "https://www.bharian.com.my/feed" }
    }
end
