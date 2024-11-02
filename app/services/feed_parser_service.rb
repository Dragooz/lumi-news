# app/services/feed_parser_service.rb

# This service class is responsible for parsing RSS/Atom feeds from publishers
class FeedParserService
  def self.parse_feed_for_publisher(publisher)
    # puts "\n=== Starting parse method ==="
    # puts "Publisher details:"
    # puts "  Name: #{publisher.name}"
    # puts "  Feed URL: #{publisher.feed_url}"
    # puts "  ID: #{publisher.id}"

    result = new(publisher).process_feed
    # puts "\nFinal result:"
    # puts "  Number of entries: #{result.length}"
    # puts "  Result array: #{result.inspect}"
    # puts "=== End parse method ===\n"
    result
  rescue StandardError => e
    # puts "\nERROR in parse method:"
    # puts "  Publisher: #{publisher.name}"
    # puts "  Error class: #{e.class}"
    # puts "  Error message: #{e.message}"
    # puts "  Backtrace: #{e.backtrace[0..2].join("\n    ")}"
    Rails.logger.error("Error parsing feed for #{publisher.name}: #{e.message}")
    []
  end

  def initialize(publisher)
    # puts "\n=== Initializing FeedParserService ==="
    # puts "Publisher object:"
    # puts "  Name: #{publisher.name}"
    # puts "  Feed URL: #{publisher.feed_url}"
    # puts "  ID: #{publisher.id}"
    @publisher = publisher
  end

  def process_feed
    # puts "\n=== Starting feed processing ==="
    # puts "Publisher being used:"
    # puts "  Name: #{@publisher.name}"
    # puts "  Feed URL: #{@publisher.feed_url}"

    raw_feed_content = fetch_feed_content
    # puts "\nFeed content length: #{raw_feed_content.length} characters"
    # puts "Feed content preview: #{raw_feed_content[0..100]}..."

    parsed_feed = Feedjira.parse(raw_feed_content)
    # puts "\nParsed feed details:"
    # puts "  Feed title: #{parsed_feed.title rescue 'N/A'}"
    # puts "  Number of entries: #{parsed_feed.entries.count}"
    # puts "  Feed type: #{parsed_feed.class}"

    # puts "\nProcessing entries..."
    parsed_feed.entries.map.with_index do |entry, index|
      #   puts "\nEntry #{index + 1} of #{parsed_feed.entries.count}:"
      # parsed_feed.entries.take(2).map.with_index do |entry, index|
      # puts "\nEntry #{index + 1} of 2:"
      extract_entry_data(entry)
    end
  end

  private

  def fetch_feed_content
    # puts "\n=== Fetching feed ==="
    # puts "Request URL: #{@publisher.feed_url}"

    response = HTTParty.get(@publisher.feed_url)
    # puts "\nResponse details:"
    # puts "  Status code: #{response.code}"
    # puts "  Response headers: #{response.headers.inspect}"
    # puts "  Response size: #{response.body.length} bytes"

    unless response.success?
      # puts "ERROR: HTTP Request failed"
      # puts "  Status code: #{response.code}"
      # puts "  Response body: #{response.body[0..200]}"
      raise "Failed to fetch feed: #{response.code}"
    end

    response.body
  end

  def extract_entry_data(entry)
    # puts "\n  === Parsing entry ==="
    # puts "  Entry object details:"
    # puts "    Class: #{entry.class}"
    # puts "    Available methods: #{entry.public_methods(false).sort}"

    entry_data = {
      title: entry.title,
      published_at: entry.published,
      original_url: entry.url,
      image_url: find_entry_image_url(entry)
    }

    # puts "\n  Parsed entry details:"
    entry_data.each do |key, value|
      puts "    #{key}: #{value.inspect}"
    end

    entry_data
  end

  def find_entry_image_url(entry)
    # puts "\n  === Extracting image URL ==="
    # puts "  Entry responds to image?: #{entry.respond_to?(:image)}"

    if entry.respond_to?(:image)
      image_url = entry.image
      # puts "  Found image URL: #{image_url}"
      image_url
    else
      # puts "  No image method available"
      # puts "  Available methods: #{entry.public_methods(false).sort}"
      nil
    end
  end
end
