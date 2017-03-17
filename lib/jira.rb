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
  attr_accessor :client

  def initialize
    options = JIRA_COMMON::options
    @client = JIRA::Client.new(options)
  end
end
