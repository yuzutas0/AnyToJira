# encoding:utf-8

require 'dotenv'
Dotenv.load '.env'

require 'mechanize'
require 'open-uri'
require 'oauth'
require 'jira-ruby'

# -----------------------------------------------
# Confluence -> JIRA
# -----------------------------------------------

options = {
    :username        => ENV['JIRA_MAILADDRESS'],
    :password        => ENV['JIRA_PASSWORD'],
    :site            => ENV['JIRA_HOST'],
    :context_path    => '/jira',
    :use_ssl         => false,
    :auth_type       => :basic
}

client = JIRA::Client.new(options)
project_id = client.Project.find(ENV['JIRA_PROJECT_NAME']).id
issue_type = client.Issuetype.all.find { |type| type.name == ENV['JIRA_ISSUE_NAME'] }.id

issue = client.Issue.build
response = issue.save(
    {
        fields: {
            summary: '自動投稿テスト',
            description: '説明',
            project: {
                id: project_id
            },
            issuetype: {
                id: issue_type
            },

        }
    }
)
puts response

# agent = Mechanize.new
# agent.user_agent = 'Mac Safari'
#
# CONFLUENCE_XPATH_PREFIX = '//*[@id="main-content"]/div/table/tbody/tr['
# CONFLUENCE_XPATH_SUFFIX = ']/td[' + ENV['CONFLUENCE_TABLE_COLUMN'].to_i.to_s + ']'
#
# agent.get(ENV['CONFLUENCE_HOST'] + 'login.action') do |page|
#   page.form_with(:name => 'loginform') do |form|
#     form.os_username = ENV['JIRA_MAILADDRESS']
#     form.os_password = ENV['JIRA_PASSWORD']
#   end.submit
#
#   html = agent.get(ENV['CONFLUENCE_HOST'] + 'pages/viewpage.action?pageId=' + ENV['CONFLUENCE_PAGE']).content.toutf8
#   contents = Nokogiri::HTML(html, nil, 'utf-8')
#
#   result = []
#   ENV['CONFLUENCE_TABLE_START_ROW'].to_i.upto(ENV['CONFLUENCE_TABLE_END_ROW'].to_i) do |index|
#     confluence_xpath = CONFLUENCE_XPATH_PREFIX + index.to_s + CONFLUENCE_XPATH_SUFFIX
#     break if contents.xpath(confluence_xpath).empty?
#
#     unless contents.xpath(confluence_xpath).xpath('.//li').empty?
#       list_word = contents.xpath(confluence_xpath).xpath('.//li').text.to_s
#       list_word = list_word[0..4] if list_word.size > 5
#       text = contents.xpath(confluence_xpath).text.to_s
#       result << text.split(list_word)[0]
#       next
#     end
#
#     text = contents.xpath(confluence_xpath).text.to_s
#     result << text unless text.empty?
#   end
#   puts result
# end

# TODO: JIRA -> JIRA
# TODO: Github Issue -> JIRA
# TODO: TODO/FIXME in Code -> JIRA
