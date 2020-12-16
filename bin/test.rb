require 'nokogiri'
require 'open-uri'
require 'webdrivers'
require 'watir'

# Fetch and parse HTML document
puts doc = Nokogiri::HTML(URI.open('https://fantasy.premierleague.com/entry/1/history'))

puts '### Search for nodes by css'
puts x = doc.xpath('/html/body/main/div/div[2]/div/div[1]/div[2]/div[2]')
doc.xpath('/html/body/main/div/div[2]/div/div[1]/div[2]/div[2]').each do |link|
  puts link
end

# puts '### Search for nodes by xpath'
# doc.xpath('//nav//ul//li/a', '//article//h2').each do |link|
#   puts link.content
# end

# puts '### Or mix and match.'
# doc.search('nav ul.menu li a', '//article//h2').each do |link|
#   puts link.content
# end

# /html/body/main/div/div[2]/div/div[1]

# root > div:nth-child(2) > div > div.Layout__Main-eg6k6r-1.haICgV

# //*[@id="root"]/div[2]/div/div[1]/div[2]
