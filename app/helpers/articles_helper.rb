module ArticlesHelper
  def language_name(code)
    {
      "en" => "English",
      "ms" => "Malay"
      # Add more mappings as needed
    }[code] || code
  end
end
