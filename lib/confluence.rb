# encoding:utf-8

# -----------------------------------------------
# Require
# -----------------------------------------------
require 'dotenv'
Dotenv.load '.env'

require 'mechanize'
require 'open-uri'
require 'kconv'
require 'oauth'

# -----------------------------------------------
# Confluence -> JIRA
# -----------------------------------------------
class CONFLUENCE
  CONFLUENCE_XPATH_PREFIX = '//*[@id="main-content"]/div/table/tbody/tr['
  CONFLUENCE_XPATH_SUFFIX = ']/td[' + ENV['CONFLUENCE_TABLE_COLUMN'].to_i.to_s + ']'
  CONFLUENCE_PAGE = ENV['CONFLUENCE_URL'] + 'pages/viewpage.action?pageId=' + ENV['CONFLUENCE_PAGE']

  def self.titles
    confluence_result, agent = [], mechanize_agent
    agent.get(ENV['CONFLUENCE_URL'] + 'login.action') do |page|
      login(page)
      contents = crawl(agent)
      start_row, end_row = ENV['CONFLUENCE_TABLE_START_ROW'].to_i, ENV['CONFLUENCE_TABLE_END_ROW'].to_i
      start_row.upto(end_row) { |index| confluence_result << scrape(contents, index) }
    end
    confluence_result.compact.reject(&:empty?)
  end

  private

  def mechanize_agent
    agent = Mechanize.new
    agent.user_agent = 'Mac Safari'
    agent
  end

  def login(page)
    page.form_with(:name => 'loginform') do |form|
      form.os_username = ENV['JIRA_MAILADDRESS']
      form.os_password = ENV['JIRA_PASSWORD']
    end.submit
  end

  def crawl(agent)
    html = agent.get(CONFLUENCE_PAGE).content.toutf8
    Nokogiri::HTML(html, nil, 'utf-8')
  end

  def scrape(contents='', index=0)
    confluence_xpath = CONFLUENCE_XPATH_PREFIX + index.to_s + CONFLUENCE_XPATH_SUFFIX
    return '' if contents.xpath(confluence_xpath).empty?
    return scrape_content_with_list(contents, confluence_xpath) unless contents.xpath(confluence_xpath).xpath('.//li').empty?
    contents.xpath(confluence_xpath).text.to_s
  end

  def scrape_content_with_list(contents, confluence_xpath)
    list_word = contents.xpath(confluence_xpath).xpath('.//li').text.to_s
    list_word = list_word[0..4] if list_word.size > 5
    text = contents.xpath(confluence_xpath).text.to_s
    text.split(list_word)[0]
  end
end
