# encoding:utf-8

# -----------------------------------------------
# Require
# -----------------------------------------------
require 'dotenv'
Dotenv.load '.env'

# -----------------------------------------------
# XXX -> JIRA
# -----------------------------------------------
require './lib/jira_sender'
sender = JIRA_SENDER.new
# *** usage ***
# sender.send_jira('title', 'description')

# -----------------------------------------------
# Confluence -> JIRA
# -----------------------------------------------
require './lib/confluence'
# CONFLUENCE::titles.each { |title| sender.send_jira(title, CONFLUENCE::CONFLUENCE_PAGE) }

# -----------------------------------------------
# Redmine -> JIRA
# -----------------------------------------------
require './lib/redmine'
# issues = REDMINE::issues

# -----------------------------------------------
# JIRA -> JIRA
# -----------------------------------------------
require './lib/jira_receiver'
# issues = JIRA_RECEIVER::issues

# -----------------------------------------------
# Execute
# -----------------------------------------------
issues.each { |title, link| sender.send_jira(title, link) }

# TODO: Github Issue -> JIRA
# TODO: TODO/FIXME in Code -> JIRA
