# encoding:utf-8

# -----------------------------------------------
# Require
# -----------------------------------------------
require 'dotenv'
Dotenv.load '.env'

require 'jira-ruby'
require './jira_common'

# -----------------------------------------------
# XXX -> JIRA
# -----------------------------------------------
class JIRA_SENDER
  attr_accessor :client, :project_id, :issue_type

  def initialize
    @client = JIRA::Client.new(JIRA_COMMON::options)
    @project_id = @client.Project.find(ENV['JIRA_PROJECT_NAME']).id
    @issue_type = @client.Issuetype.all.find { |type| type.name == ENV['JIRA_ISSUE_NAME'] }.id
  end

  def send_jira(summary, description)
    # return if self.validation(summary)
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

  # def validation(summary)
  #   already_exist = @client.Issue.jql("PROJECT = #{ENV['JIRA_PROJECT_NAME']}").any? do |issue|
  #     issue.issuetype.id == @issue_type &&
  #         issue.project.id == @project_id &&
  #         issue.summary == summary
  #   end
  #   puts 'already exist : ' + summary if already_exist
  #   already_exist
  # end
end
