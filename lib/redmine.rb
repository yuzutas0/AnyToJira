# encoding:utf-8
# frozen_string_literal: true

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
class Redmine
  URL_PREFIX = "#{ENV['REDMINE_URL']}/projects/" \
               "#{ENV['REDMINE_PROJECT_NAME']}/issues.json?" \
               "key=#{ENV['REDMINE_API_KEY']}&" \
               "query_id=#{ENV['REDMINE_QUERY_ID']}"
  LIMIT_SIZE = 100

  class << self
    def issues
      pages = request['total_count'].to_i / LIMIT_SIZE + 1
      issues = {}
      pages.times do |page|
        this_page = page + 1
        items = request(LIMIT_SIZE, this_page)['issues']
        puts "page=#{this_page}/#{pages} : #{items.length} issues found!"
        items.each { |issue| issues[issue['subject']] = url_of(issue) }
      end
      issues # => { 'issue_subject': 'issue_url', ... }
    end

    private

    def request(limit = 1, page = 1)
      request = "#{URL_PREFIX}&limit=#{limit}&page=#{page}"
      response = open(request, &:read).toutf8
      JSON.parse(response)
    end

    def url_of(issue)
      "#{ENV['REDMINE_URL']}issues/#{issue['id']}"
    end
  end
end
