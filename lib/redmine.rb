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

  def self.request
    request = URL_PREFIX + '&limit=1' + '&page=1'

    response = open(request, &:read).toutf8
    parsed = JSON.parse response

    puts parsed
  end
end
