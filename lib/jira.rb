# encoding:utf-8

# -----------------------------------------------
# Require
# -----------------------------------------------
require 'dotenv'
Dotenv.load '.env'

require 'jira-ruby'

# -----------------------------------------------
# JIRA -> JIRA
# -----------------------------------------------
class JIRA
  attr_accessor :client

  def initialize
    options = {
        :username        => ENV['JIRA_MAILADDRESS'],
        :password        => ENV['JIRA_PASSWORD'],
        :site            => ENV['JIRA_HOST'],
        :context_path    => ENV['JIRA_CONTEXT_PATH'],
        :use_ssl         => false,
        :auth_type       => :basic
    }

    @client = JIRA::Client.new(options)
  end
end
