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
# _issues.merge! CONFLUENCE::issues

# -----------------------------------------------
# Redmine -> JIRA
# -----------------------------------------------
require './lib/redmine'
# _issues.merge! REDMINE::issues

# -----------------------------------------------
# JIRA -> JIRA
# -----------------------------------------------
require './lib/jira_receiver'
# _issues.merge! JIRA_RECEIVER::issues

# -----------------------------------------------
# Github -> JIRA
# -----------------------------------------------
require './lib/github'
# _issues.merge! GITHUB::issues

# -----------------------------------------------
# Execute
# -----------------------------------------------
require './lib/jira_sender'
_sender = JIRA_SENDER.new
# _issues.each { |title, link| _sender.send_jira(title, link) }
