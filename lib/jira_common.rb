# encoding:utf-8

# -----------------------------------------------
# Require
# -----------------------------------------------
require 'dotenv'
Dotenv.load '.env'

# -----------------------------------------------
# Settings
# -----------------------------------------------
class JIRA_COMMON
  def self.options
    {
        :username        => ENV['JIRA_MAILADDRESS'],
        :password        => ENV['JIRA_PASSWORD'],
        :site            => ENV['JIRA_HOST'],
        :context_path    => ENV['JIRA_CONTEXT_PATH'],
        :use_ssl         => false,
        :auth_type       => :basic
    }
  end
end
