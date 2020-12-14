require 'byebug'
require 'nokogiri'
require 'open-uri'
require 'watir'
require 'webdrivers'
require_relative '../lib/validation'
require_relative '../lib/scraper'

play_again = 'Y'

def new_player
  puts 'Insert player id'
  id = gets.chomp.strip
  check = false
  valid_obj = Valid.new
  until check == true
    check = valid_obj.validate(id)
    next unless check == false

    p check
    puts 'Your Id is invalid', ''
    puts
    puts 'Enter correct Id', ''
    id = gets.chomp.strip
  end
  puts "You entered the id  #{id}"
  id
end

while %w[y Y].include?(play_again)
  id = new_player
  scrape = Scraper.new(id)
  data = scrape.scraper_tool
  puts 'Would you like to check more ids? Press Y to continue, anything else to quit', ''
  play_again = gets.chomp.strip
end

# root > div:nth-child(2) > div > div.Layout__Main-eg6k6r-1.haICgV > div:nth-child(2) >
# div.Table__ScrollTable-ziussd-0.canFyp > table > tbody
# Fetch and parse HTML document
# doc = Nokogiri::HTML(URI.open('https://en.wikipedia.org/wiki/Douglas_Adams'))

# puts '### Search for nodes by css'
# doc.css('nav ul.menu li a', 'article h2').each do |link|
#   puts link.content
# end

# puts '### Search for nodes by xpath'
# doc.xpath('//nav//ul//li/a', '//article//h2').each do |link|
#   puts link.content
# end

# puts '### Or mix and match.'
# doc.search('nav ul.menu li a', '//article//h2').each do |link|
#   puts link.content
# end
