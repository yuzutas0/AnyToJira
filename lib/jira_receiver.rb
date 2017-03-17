# encoding:utf-8

# -----------------------------------------------
# Require
# -----------------------------------------------
require 'dotenv'
Dotenv.load '.env'

require 'jira-ruby'
require './lib/jira_common'

# -----------------------------------------------
# JIRA -> JIRA
# -----------------------------------------------
class JIRA_RECEIVER
  def self.issues
    client = JIRA::Client.new(JIRA_COMMON::options)
    issues = client.Issue.jql(ENV['JIRA_JQL'])
    puts issues.length
  end
end
