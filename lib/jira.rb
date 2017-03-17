# encoding:utf-8

# -----------------------------------------------
# Require
# -----------------------------------------------
require 'dotenv'
Dotenv.load '.env'

require 'jira-ruby'
require './jira_common'

# -----------------------------------------------
# JIRA -> JIRA
# -----------------------------------------------
class JIRA
  def self.issues
    client = JIRA::Client.new(JIRA_COMMON::options)
  end
end
