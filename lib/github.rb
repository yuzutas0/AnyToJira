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
# Github -> JIRA
# -----------------------------------------------
class GITHUB
  def self.issues
    client = Octokit::Client.new(:access_token => ENV['GITHUB_TOKEN'])
    ENV['GITHUB_REPOSITORIES'].split(',').each do |repository|
      puts client.issues "#{ENV['GITHUB_ORGANIZATION']}/#{repository}"
    end
    []
  end
end
