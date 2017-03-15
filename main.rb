# encoding:utf-8

require 'dotenv'
Dotenv.load '.env'

require 'mechanize'
require 'open-uri'

# TODO: Confluence -> JIRA

agent = Mechanize.new
agent.user_agent = 'Mac Safari'
agent.get(ENV['JIRA_HOST'] + 'login.action') do |page|
  page.form_with(:name => 'loginform') do |form|
    form.os_username = ENV['JIRA_MAILADDRESS']
    form.os_password = ENV['JIRA_PASSWORD']
  end.submit

  content = agent.get(ENV['JIRA_HOST'] + 'pages/viewpage.action?pageId=' + ENV['JIRA_PAGE']).content.toutf8
  puts content
end

# TODO: JIRA -> JIRA
# TODO: Github Issue -> JIRA
# TODO: TODO/FIXME in Code -> JIRA
