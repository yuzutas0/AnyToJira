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
    issues = []
    client = Octokit::Client.new(:access_token => ENV['GITHUB_TOKEN'])
    ENV['GITHUB_REPOSITORIES'].split(',').each do |repository|
      client.issues("#{ENV['GITHUB_ORGANIZATION']}/#{repository}").each do |issue|
        puts issue.title
        puts "https://github.com/#{ENV['GITHUB_ORGANIZATION']}/#{repository}/issues/#{issue.number}"
        puts '*****'
      end
    end
    issues
  end
end
