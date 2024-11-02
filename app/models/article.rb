class Article < ApplicationRecord
  belongs_to :publisher

  validates :title, presence: true
  validates :published_at, presence: true
  validates :original_url, presence: true, uniqueness: true

  scope :latest, -> { order(published_at: :desc) }
  scope :by_language, ->(language) { joins(:publisher).where(publishers: { language: language }) }
end
