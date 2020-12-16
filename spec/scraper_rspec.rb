require_relative '../lib/scraper'
require 'csv'
require 'nokogiri'
require 'watir'
require 'webdrivers'

top = Top.new
describe Top do
  context '#browserini Intializing the browser for the first time. Start with first link' do
    it 'Initializing the browser' do
      top.counter = 1
      expect(top.browser_ini).to eq('https://fantasy.premierleague.com/leagues/314/standings/c?phase=1&page_new_entries=1&page_standings=1')
    end
  end

  context 'Scraping multiple pages one after the other' do
    top.browser = Watir::Browser.new
    top.counter = 10
    it 'Counter is passed and page 11 is used for pagination' do
      expect(top.pagination100.count).to eq(50)
    end
    it 'Counter is passed and page 11 is used for pagination & data is lesser than 50' do
      expect(top.pagination100.count).to be_truthy
    end
  end

  context 'Passing a random link from any of the league pages to checking for all methods with the link' do
    top.browser = Watir::Browser.new
    top.browser.goto 'https://fantasy.premierleague.com/leagues/314/standings/c?phase=1&page_new_entries=1&page_standings=5'
    gw = top.top100noko
    it 'If the data scrapped is 50 or >50' do
      expect(gw.count).to eq(50)
    end
    it 'If the data scrapped is <50 & count is not known' do
      expect(gw.count).to be_truthy
    end
    it 'Inserting headers based on link into csv' do
      top.gwdata = gw
      expect(top.header).to be_truthy
    end
    it 'Inserting indiviual rows in gw into csv' do
      top.gwdata = gw
      expect(top.top100.count).to eq(50)
    end
    it 'If the data scrapped is <50 & count is not known' do
      expect(top.top100.count).to be_truthy
    end
  end
end
