# encoding:utf-8

# -----------------------------------------------
# Require
# -----------------------------------------------
require 'dotenv'
Dotenv.load '.env'

require 'mechanize'
require 'open-uri'
require 'oauth'

# -----------------------------------------------
# XXX -> JIRA
# -----------------------------------------------
require './lib/jira_sender'
sender = JIRA_SENDER.new

# -----------------------------------------------
# Confluence -> JIRA
# -----------------------------------------------

class CONFLUENCE
  CONFLUENCE_XPATH_PREFIX = '//*[@id="main-content"]/div/table/tbody/tr['
  CONFLUENCE_XPATH_SUFFIX = ']/td[' + ENV['CONFLUENCE_TABLE_COLUMN'].to_i.to_s + ']'
  CONFLUENCE_PAGE = ENV['CONFLUENCE_HOST'] + 'pages/viewpage.action?pageId=' + ENV['CONFLUENCE_PAGE']

  def self.titles
    confluence_result = []

    agent = Mechanize.new
    agent.user_agent = 'Mac Safari'

    agent.get(ENV['CONFLUENCE_HOST'] + 'login.action') do |page|
      page.form_with(:name => 'loginform') do |form|
        form.os_username = ENV['JIRA_MAILADDRESS']
        form.os_password = ENV['JIRA_PASSWORD']
      end.submit

      html = agent.get(CONFLUENCE_PAGE).content.toutf8
      contents = Nokogiri::HTML(html, nil, 'utf-8')

      ENV['CONFLUENCE_TABLE_START_ROW'].to_i.upto(ENV['CONFLUENCE_TABLE_END_ROW'].to_i) do |index|
        confluence_xpath = CONFLUENCE_XPATH_PREFIX + index.to_s + CONFLUENCE_XPATH_SUFFIX
        break if contents.xpath(confluence_xpath).empty?

        unless contents.xpath(confluence_xpath).xpath('.//li').empty?
          list_word = contents.xpath(confluence_xpath).xpath('.//li').text.to_s
          list_word = list_word[0..4] if list_word.size > 5
          text = contents.xpath(confluence_xpath).text.to_s
          confluence_result << text.split(list_word)[0]
          next
        end

        text = contents.xpath(confluence_xpath).text.to_s
        confluence_result << text unless text.empty?
      end
    end
    confluence_result
  end
end

# CONFLUENCE::titles.each { |title| sender.send_jira(title, CONFLUENCE::CONFLUENCE_PAGE) }


# TODO: JIRA -> JIRA
# TODO: Github Issue -> JIRA
# TODO: TODO/FIXME in Code -> JIRA
