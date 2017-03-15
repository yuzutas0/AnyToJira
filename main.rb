# encoding:utf-8

require 'dotenv'
Dotenv.load '.env'

require 'mechanize'

# TODO: Confluence -> JIRA

agent = Mechanize.new
agent.user_agent = 'Mac Safari'
agent.get('host/login.action') do |page|
  page.form_with(:name => 'loginform') do |form|
    form.os_username = 'mail'
    form.os_password = 'password'
  end.submit

  agent.get('host/pages/viewpage.action?pageId=xxx') do |page|
    puts page.inspect
  end
end

# TODO: JIRA -> JIRA
# TODO: Github Issue -> JIRA
# TODO: TODO/FIXME in Code -> JIRA
