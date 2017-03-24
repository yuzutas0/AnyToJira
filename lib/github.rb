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
  URL_HOST = "https://api.github.com/repos/#{ENV['GITHUB_ORGANIZATION']}/repo"

  def self.issues
    []
  end
end
