# encoding:utf-8

require 'dotenv'
Dotenv.load '.env'

require 'mechanize'
require 'open-uri'

# -----------------------------------------------
# Confluence -> JIRA
# -----------------------------------------------

agent = Mechanize.new
agent.user_agent = 'Mac Safari'

JIRA_XPATH_PREFIX = '//*[@id="main-content"]/div/table/tbody/tr['
JIRA_XPATH_SUFFIX = ']/td[' + ENV['JIRA_TABLE_COLUMN'].to_i.to_s + ']'

agent.get(ENV['JIRA_HOST'] + 'login.action') do |page|
  page.form_with(:name => 'loginform') do |form|
    form.os_username = ENV['JIRA_MAILADDRESS']
    form.os_password = ENV['JIRA_PASSWORD']
  end.submit

  html = agent.get(ENV['JIRA_HOST'] + 'pages/viewpage.action?pageId=' + ENV['JIRA_PAGE']).content.toutf8
  contents = Nokogiri::HTML(html, nil, 'utf-8')

  result = []
  ENV['JIRA_TABLE_START_ROW'].to_i.upto(ENV['JIRA_TABLE_END_ROW'].to_i) do |index|
    jira_xpath = JIRA_XPATH_PREFIX + index.to_s + JIRA_XPATH_SUFFIX
    break if contents.xpath(jira_xpath).empty?

    unless contents.xpath(jira_xpath).xpath('.//li').empty?
      list_word = contents.xpath(jira_xpath).xpath('.//li').text.to_s
      list_word = list_word[0..4] if list_word.size > 5
      text = contents.xpath(jira_xpath).text.to_s
      result << text.split(list_word)[0]
      next
    end

    text = contents.xpath(jira_xpath).text.to_s
    result << text unless text.empty?
  end
  puts result
end

# TODO: JIRA -> JIRA
# TODO: Github Issue -> JIRA
# TODO: TODO/FIXME in Code -> JIRA
