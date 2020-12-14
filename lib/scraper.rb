class Scraper
  attr_reader :player_id

  def initialize(id)
    @player_id = id
    @browser = Watir::Browser.new
    @browser.goto "https://fantasy.premierleague.com/entry/#{player_id}/history"
    @playerdata = []
  end

  def scraper_tool
    @browser.element(xpath: '/html/body/main/div/div[2]/div/div[2]')\
      .wait_until(&:present?)
    parsed = Nokogiri::HTML(@browser.html)
    parsed1 = parsed.css('#root > div:nth-child(2) > div > div.Layout__Main-eg6k6r-1.haICgV > div:nth-child(2) >
    div.Table__ScrollTable-ziussd-0.canFyp')
    headings = parsed1.css('thead')
    rows = parsed1.css('tbody > tr')
    rows.each do |inside|
      td1 = inside.css('td')
      overall = { GW: td1[0].text, Link: 'https://fantasy.premierleague.com/' + td1[0].css('a')[0].attributes['href'].value,
                  GP: td1[1].text, PB: td1[2].text, GR: td1[3].text, TM: td1[4].text,
                  TC: td1[5].text, OP: td1[6].text, OR: td1[7].text, Value: td1[8].text, Rank: td1[9] }
      @playerdata << overall
    end
    byebug

    # inside.each do {

    # }
    # td1=rows[0].css('td')
    # {

    #     td = { GW: 10, font_family: "Arial" }
    #     }
    # }
  end
end

# parsed1 = parsed.css('#root > div:nth-child(2) > div > div.Layout__Main-eg6k6r-1.haICgV > div:nth-child(2) > div.Table__ScrollTable-ziussd-0.canFyp')
# headings = parsed1.css('thead')
# rows = parsed1.css('tbody > tr')
