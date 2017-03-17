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
# require './lib/confluence'
# CONFLUENCE::titles.each { |title| sender.send_jira(title, CONFLUENCE::CONFLUENCE_PAGE) }

# -----------------------------------------------
# Redmine -> JIRA
# -----------------------------------------------
# require './lib/redmine'
# REDMINE::issues.each { |title, link| sender.send_jira(title, link) }

# -----------------------------------------------
# JIRA -> JIRA
# -----------------------------------------------
require './lib/jira_receiver'
JIRA_RECEIVER::issues

# TODO: Github Issue -> JIRA
# TODO: TODO/FIXME in Code -> JIRA
