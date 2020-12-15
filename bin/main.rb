require 'byebug'
require 'csv'
require 'nokogiri'
require 'open-uri'
require 'watir'
require 'webdrivers'
require_relative '../lib/validation'
require_relative '../lib/scraper'

# play_again = 'Y'

# def new_player
#   puts 'Insert player id'
#   id = gets.chomp.strip
#   check = false
#   valid_obj = Valid.new
#   until check == true
#     check = valid_obj.validate(id)
#     next unless check == false

#     p check
#     puts 'Your Id is invalid', ''
#     puts
#     puts 'Enter correct Id', ''
#     id = gets.chomp.strip
#   end
#   puts "You entered the id  #{id}"
#   id
# end

class Intro
  def start
    scraper_intro
    take_input
    check_page
  end

  private

  def scraper_intro
    puts 'Welcome to The FPL Data Scraper'
    puts 'Here you can get the data of Top FPL Players into your CSV file'
    puts 'Insert a number in multiples of 50 to scrape data from'
    puts 'If you input 50, top 50 players data with link would be available and so on'
  end

  def take_input
    number = gets.chomp.strip.to_i
    until (number % 50).zero? && number != 0
      puts 'Invalid Number, please enter valid number'
      number = gets.chomp.strip.to_i
    end
    @newnumber = (number / 50) - 1
  end

  def check_page
    top100 = Top.new
    top100.top100noko
    top100.header
    top100.top100

    while @newnumber.positive?
      top100.pagination100
      @newnumber -= 1
    end
    puts
    puts 'Your file is ready!'
  end
end

intro = Intro.new
intro.start

#  top100.csv

# while %w[y Y].include?(play_again)
#   id = new_player
#   scrape = Scraper.new(id)
#   data = scrape.scraper_tool
#   puts 'Would you like to check more ids? Press Y to continue, anything else to quit', ''
#   play_again = gets.chomp.strip
# end

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
