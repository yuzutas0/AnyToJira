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
    issues = {}
    client.Issue.jql(ENV['JIRA_JQL']).each { |issue| issues[issue.summary] = "#{ENV['JIRA_HOST']}#{ENV['JIRA_CONTEXT_PATH']}/browse/#{issue.key}" }
    issues
  end
end
