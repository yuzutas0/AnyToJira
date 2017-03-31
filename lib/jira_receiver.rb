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
class JiraReceiver
  URL_PREFIX = "#{ENV['JIRA_HOST']}#{ENV['JIRA_CONTEXT_PATH']}/browse/"

  class << self
    def issues
      client = JIRA::Client.new(JIRA_COMMON.options)
      issues = {}
      client.Issue.jql(ENV['JIRA_JQL']).each do |issue|
        issues[issue.summary] = URL_PREFIX + issue.key
      end
      issues
    end
  end
end
