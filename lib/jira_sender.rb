# encoding:utf-8

# -----------------------------------------------
# Require
# -----------------------------------------------
require 'dotenv'
Dotenv.load '.env'

require 'jira-ruby'

# -----------------------------------------------
# XXX -> JIRA
# -----------------------------------------------
class JIRA_SENDER
  attr_accessor :client, :project_id, :issue_type

  def initialize
    options = {
        :username        => ENV['JIRA_MAILADDRESS'],
        :password        => ENV['JIRA_PASSWORD'],
        :site            => ENV['JIRA_HOST'],
        :context_path    => '/jira',
        :use_ssl         => false,
        :auth_type       => :basic
    }

    @client = JIRA::Client.new(options)
    @project_id = @client.Project.find(ENV['JIRA_PROJECT_NAME']).id
    @issue_type = @client.Issuetype.all.find { |type| type.name == ENV['JIRA_ISSUE_NAME'] }.id
  end

  def send_jira(summary, description)
    issue = @client.Issue.build
    response = issue.save(
        {
            fields: {
                summary: summary,
                description: "Created by #{ENV['JIRA_MAILADDRESS']} Script 'AnyToJira'\n\n#{description}",
                labels: [
                    ENV['JIRA_LABEL']
                ],
                project: {
                    id: @project_id
                },
                issuetype: {
                    id: @issue_type
                }
            }
        }
    )
    puts response unless response
  end
end
