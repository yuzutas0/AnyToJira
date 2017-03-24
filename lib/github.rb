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
    client = Octokit::Client.new(:access_token => ENV['GITHUB_TOKEN'])
    ENV['GITHUB_REPOSITORIES'].split(',').each do |repository|
      client.issues("#{ENV['GITHUB_ORGANIZATION']}/#{repository}").each { |issue| puts issue.inspect }
    end
    []
  end
end
