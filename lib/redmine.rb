# encoding:utf-8

# -----------------------------------------------
# Require
# -----------------------------------------------
require 'dotenv'
Dotenv.load '.env'

require 'open-uri'
require 'kconv'
require 'json'

# -----------------------------------------------
# Redmine -> JIRA
# -----------------------------------------------
class REDMINE
  URL_HOST = "#{ENV['REDMINE_URL']}/projects/#{ENV['REDMINE_PROJECT_NAME']}/issues.json"
  URL_PARAMS = "?key=#{ENV['REDMINE_API_KEY']}&query_id=#{ENV['REDMINE_QUERY_ID']}"
  URL_PREFIX = URL_HOST + URL_PARAMS
  LIMIT_SIZE = 100

  def self.request
    pages, issues = call_api['total_count'].to_i / LIMIT_SIZE + 1, {}
    pages.times { |page| call_api(LIMIT_SIZE, page)['issues'].each { |issue| issues[issue['id']] = issue['subject'] } }
    issues # => {issue_number: 'issue_subject', ... }
  end

  def self.call_api(limit=1, page=1)
    request = "#{URL_PREFIX}&limit=#{limit}&page=#{page}"
    response = open(request, &:read).toutf8
    JSON.parse(response)
  end
end
