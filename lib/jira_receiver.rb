# encoding:utf-8
# frozen_string_literal: true

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
  JIRA_ISSUE_URL_PREFIX = "#{ENV['JIRA_HOST']}#{ENV['JIRA_CONTEXT_PATH']}/browse/"

  def self.issues
    client = JIRA::Client.new(JIRA_COMMON.options)
    issues = {}
    client.Issue.jql(ENV['JIRA_JQL']).each { |issue| issues[issue.summary] = JIRA_ISSUE_URL_PREFIX + issue.key }
    issues
  end
end
