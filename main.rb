# encoding:utf-8

# -----------------------------------------------
# Require
# -----------------------------------------------
require 'dotenv'
Dotenv.load '.env'

# -----------------------------------------------
# Confluence -> JIRA
# -----------------------------------------------
require './lib/confluence'
# issues = CONFLUENCE::issues

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
# Github -> JIRA
# -----------------------------------------------
require './lib/github'
issues = GITHUB::issues

# TODO: TODO/FIXME in Code -> JIRA

# -----------------------------------------------
# Execute
# -----------------------------------------------
require './lib/jira_sender'
sender = JIRA_SENDER.new
# issues.each { |title, link| sender.send_jira(title, link) }
