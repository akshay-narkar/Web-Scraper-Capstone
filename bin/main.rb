require 'byebug'
require 'csv'
require 'nokogiri'
require 'open-uri'
require 'watir'
require 'webdrivers'
require_relative '../lib/scraper'

class Intro
  def start
    scraper_intro
    take_input
    check_page
  end

  private

  def scraper_intro
    puts
    puts 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
    puts 'x                                      x'
    puts 'x     Welcome to the FPL Scraper!!!    x'
    puts 'x                                      x'
    puts 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
    puts
    puts "\nHere you can get the data of Top FPL Players into your CSV file. Currently scraping from League - Overall."
    puts "\nInsert a number in multiples of 50 to scrape data from."
    puts "\nIf you input 50, top 50 players data with link would be available and so on..."
    puts
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
    top100.browser_ini
    top100.top100noko
    top100.header
    top100.top100

    while @newnumber.positive?
      top100.pagination100
      @newnumber -= 1
    end
    puts "\nYour data has been scraped! Please check the file in csvfiles folder!"
    puts
    puts 'It looks like this'
    puts

    puts top100.top10[0..5]
    puts
    puts '& so on ......'
  end
end

intro = Intro.new
intro.start
