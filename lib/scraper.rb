class TopHeader
  attr_accessor :browser, :gwdata, :counter
  attr_reader :top10

  def initialize
    @counter = 1
    @top10 = []
    @toparray = []
    time = Time.now
    @timestamp = "#{time.day}-#{time.month}-#{time.year}"
  end

  def browser_ini
    @browser = Watir::Browser.new
    @browser.goto 'https://fantasy.premierleague.com/leagues/314/standings/c?phase=1&page_new_entries=1&page_standings'\
    "=#{counter}"
  end

  def top100noko
    @browser.element(xpath: '/html/body/main/div/div[2]/div[2]/div[1]/div/div[4]/div[2]/a').wait_until(&:present?)
    parse100 = Nokogiri::HTML(@browser.html)
    parsed100 = parse100.css('#root > div:nth-child(2) > div.Layout__Wrapper-eg6k6r-0.akyjM > '\
     ' div.Layout__Main-eg6k6r-1.haICgV > div > table > tbody')
    @gwdata = parsed100.css('tbody > tr')
  end

  def header
    td = gwdata.css('td')
    url = td[1].css('a')[0].attributes['href'].value
    @url = url[-2, 2]
    CSV.open("csvfiles/#{@timestamp}-GW#{@url}.csv", 'w+') do |csv|
      csv << ['', '', "GameWeek #{@url}"]
      csv << [' ']
      csv << %w[Rank Name Team URL(Ctrl+Click_to_check_team) GW-Points Overall_Points]
    end
  end
end

class Top < TopHeader
  def top100
    @namecounter = 1
    gwdata.each do |inside|
      td1 = inside.css('td')
      url = "https://fantasy.premierleague.com#{td1[1].css('a')[0].attributes['href'].value}"
      url1 = "\"#{url}\";\"Team Link\""
      hyperlink = "=HYPERLINK(#{url1})"
      overall = { Rank: td1[0].text,
                  Name: td1[1]
                    .xpath("//*[@id='root']/div[2]/div[2]/div[1]/div/table/tbody/tr[#{@namecounter}]/td[2]/text()")
                    .text,
                  Team: td1[1].css('strong')[0].text, URL: url, GW: td1[2].text, Total: td1[3].text }
      temparray = [td1[0].text,
                   td1[1].xpath("//*[@id='root']/div[2]/div[2]/div[1]/div/table/tbody/tr[#{@namecounter}]/td[2]/text()")
                     .text, td1[1].css('strong')[0].text, hyperlink, td1[2].text, td1[3].text]
      @top10 << overall
      @toparray << temparray
      CSV.open("csvfiles/#{@timestamp}-GW#{@url}.csv", 'a+') { |csv| csv << temparray }
      @namecounter += 1
    end
  end

  def pagination100
    @counter += 1
    @browser.goto 'https://fantasy.premierleague.com/leagues/314/standings/c?phase=1&page_new_entries=1&page_standings'\
    "=#{counter}"
    top100noko
    top100
  end
end
