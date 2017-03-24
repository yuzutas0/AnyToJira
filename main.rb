# encoding:utf-8

# -----------------------------------------------
# Require
# -----------------------------------------------
require 'dotenv'
Dotenv.load '.env'

issues = {}

# -----------------------------------------------
# Confluence -> JIRA
# -----------------------------------------------
require './lib/confluence'
# issues.merge CONFLUENCE::issues

# -----------------------------------------------
# Redmine -> JIRA
# -----------------------------------------------
require './lib/redmine'
# issues.merge REDMINE::issues

# -----------------------------------------------
# JIRA -> JIRA
# -----------------------------------------------
require './lib/jira_receiver'
# issues.merge JIRA_RECEIVER::issues

# -----------------------------------------------
# Github -> JIRA
# -----------------------------------------------
require './lib/github'
# issues.merge GITHUB::issues

# TODO: TODO/FIXME in Code -> JIRA

# -----------------------------------------------
# Execute
# -----------------------------------------------
require './lib/jira_sender'
sender = JIRA_SENDER.new
# issues.each { |title, link| sender.send_jira(title, link) }
