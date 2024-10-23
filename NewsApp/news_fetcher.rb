require 'httparty'
require 'json'

API_KEY = 'f7af9fa122de490f861539473f457870' 
BASE_URL = "https://newsapi.org/v2"

def fetch_top_headlines
  response = HTTParty.get("#{BASE_URL}/top-headlines?country=us&apiKey=#{API_KEY}&pageSize=10")
  if response.code == 200
    JSON.parse(response.body)["articles"]
  else
    puts "Error fetching the news: #{response.message}"
    []
  end
end

def save_to_json(articles)
  File.open("news.json", "w") do |file|
    file.write(JSON.pretty_generate(articles))
  end
  puts "News data saved to news.json"
end

# Fetch top 10 headlines and save them to a JSON file
articles = fetch_top_headlines
save_to_json(articles)
