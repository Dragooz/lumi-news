Publisher::PUBLISHER_CONFIGS.each do |name, config|
  Publisher.find_or_create_by!(name: name) do |publisher|
    publisher.feed_url = config[:feed_url]
    publisher.language = config[:language]
  end
end