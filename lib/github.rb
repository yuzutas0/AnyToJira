# encoding:utf-8

# -----------------------------------------------
# Require
# -----------------------------------------------
require 'dotenv'
Dotenv.load '.env'

require 'octokit'

# -----------------------------------------------
# Github -> JIRA
# -----------------------------------------------
class GITHUB
  def self.issues
    issues = {}
    client = Octokit::Client.new(:access_token => ENV['GITHUB_TOKEN'])

    ENV['GITHUB_REPOSITORIES'].split(',').each do |repository|

      responses = []
      responses.concat client.issues("#{ENV['GITHUB_ORGANIZATION']}/#{repository}")
      next_response = client.last_response.rels[:next]

      while next_response
        responses.concat next_response.get.data
        next_response = next_response.get.rels[:next]
      end

      responses.reject! { |response| response.html_url.start_with? "https://github.com/#{ENV['GITHUB_ORGANIZATION']}/#{repository}/pull/" }

      responses.each do |issue|
        puts issue.title
        puts issue.html_url
        puts '*****'
      end
    end
    issues
  end
end
