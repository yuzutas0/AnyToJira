# encoding:utf-8
# frozen_string_literal: true

# -----------------------------------------------
# Require
# -----------------------------------------------
require 'dotenv'
Dotenv.load '.env'

_issues = {}

# -----------------------------------------------
# Confluence -> JIRA
# -----------------------------------------------
require './lib/confluence'
# _issues.merge! Confluence::issues

# -----------------------------------------------
# Redmine -> JIRA
# -----------------------------------------------
require './lib/redmine'
# _issues.merge! Redmine::issues

# -----------------------------------------------
# JIRA -> JIRA
# -----------------------------------------------
require './lib/jira_receiver'
# _issues.merge! JiraReceiver::issues

# -----------------------------------------------
# Github -> JIRA
# -----------------------------------------------
require './lib/github'
# _issues.merge! Github::issues

# -----------------------------------------------
# Execute
# -----------------------------------------------
require './lib/jira_sender'
_sender = JiraSender.new
# _issues.each { |title, link| _sender.send_jira(title, link) }
