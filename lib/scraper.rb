class Scraper
  attr_reader :player_id

  def initialize(id)
    @player_id = id
    @browser = Watir::Browser.new
    @browser.goto "https://fantasy.premierleague.com/entry/#{player_id}/history"
    @playerdata = []
    @personaldata = []
  end
end
#   def scraper_tool
#     @browser.element(xpath: '/html/body/main/div/div[2]/div/div[2]/div/div[4]/div[1]/div[1]/div[2]/table/tbody/tr[1]/td[3]')
#       .wait_until(&:present?)
#     parsed = Nokogiri::HTML(@browser.html)
#     parsed1 = parsed.css('#root > div:nth-child(2) > div > div.Layout__Main-eg6k6r-1.haICgV > div:nth-child(2) >
#     div.Table__ScrollTable-ziussd-0.canFyp')
#     parsed2 = parsed.css('#root > div:nth-child(2) > div > div.Layout__Secondary-eg6k6r-2.hyNLtH > div')
#     parsed3 = parsed.css('#root > div:nth-child(2) > div > div.Layout__Secondary-eg6k6r-2.hyNLtH > div
#     > div:nth-child(5) > div.Panel__StyledPanel-sc-1nmpshp-0.eSHooN > div:nth-child(1) > div:nth-child(2)')
#     clubcoun = parsed3.css('tr>td')
#     # headings = parsed1.css('thead')
#     gwdata = parsed1.css('tbody > tr')
#     gwdata.each do |inside|
#       td1 = inside.css('td')
#       overall = { GW: td1[0].text, Link: "https://fantasy.premierleague.com#{td1[0].css('a')[0].attributes['href']
#         .value}",
#                   GP: td1[1].text, PB: td1[2].text, GR: td1[3].text, TM: td1[4].text,
#                   TC: td1[5].text, OP: td1[6].text, OR: td1[7].text, Value: td1[8].text, Rank: td1[9] }
#       @playerdata << overall
#     end
#     teamname = parsed2.css('h4')[0].text
#     playername = parsed2.css('h2')[0].text
#     club = clubcoun[2].text
#     country = clubcoun[5].text

#     overall1 = { Playername: playername, Teamname: teamname, Club: club, Country: country }
#     @personaldata << overall1
#   end
# end

class TopHeader
  attr_reader :gwdata

  def initialize
    @browser = Watir::Browser.new
    @browser.goto 'https://fantasy.premierleague.com/leagues/314/standings/c'
    @top100 = []
  end

  def top100header
    @browser.element(xpath: '/html/body/main/div/div[2]/div[2]/div[1]/div/div[3]/div[2]/a').wait_until(&:present?)
    parse100 = Nokogiri::HTML(@browser.html)
    parsed100 = parse100.css('#root > div:nth-child(2) > div.Layout__Wrapper-eg6k6r-0.akyjM > div.Layout__Main-eg6k6r-1.haICgV > div > table > tbody')
    @gwdata = parsed100.css('tbody > tr')

    # td1 = css(td[1].css('a')[0].attributes['href'].value)
    td = gwdata.css('td')
    url = td[1].css('a')[0].attributes['href'].value
    url = url[-2, 2]

    CSV.open('data.csv', 'a') do |csv|
      csv << ['', '', "GameWeek #{url}"]
      csv << [' ']
      csv << %w[Rank Name Team URL(Ctrl+Click_to_check_team) GW-Points Overall_Points]
    end
  end
end

class Top < TopHeader
  def top100
    gwdata.each do |inside|
      td1 = inside.css('td')
      url = "https://fantasy.premierleague.com#{td1[1].css('a')[0].attributes['href'].value}"
      url1 = "\"#{url}\";\"Team Link\""
      hyperlink = "=HYPERLINK(#{url1})"
      overall = { Rank: td1[0].text,
                  Name: td1[1].xpath("//*[@id='root']/div[2]/div[2]/div[1]/div/table/tbody/tr[#{td1[0].text}]/td[2]/text()").text,
                  Team: td1[1].css('strong')[0].text,
                  URL: url,
                  GW: td1[2].text, Total: td1[3].text }
      array1 = [td1[0].text, td1[1].xpath("//*[@id='root']/div[2]/div[2]/div[1]/div/table/tbody/tr[#{td1[0].text}]/td[2]/text()").text,
                td1[1].css('strong')[0].text, hyperlink, td1[2].text, td1[3].text]
      @top100 << overall

      CSV.open('data.csv', 'a') do |csv|
        csv << array1
      end
    end

    # def csv
    #   CSV.open('data.csv', 'a') do |csv|
    #     csv << array1
    #   end
    # end
  end
end
