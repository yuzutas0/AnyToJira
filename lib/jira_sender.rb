# encoding:utf-8
# frozen_string_literal: true

# -----------------------------------------------
# Require
# -----------------------------------------------
require 'dotenv'
Dotenv.load '.env'

require 'jira-ruby'
require './lib/jira_common'

# -----------------------------------------------
# XXX -> JIRA
# -----------------------------------------------
class JiraSender
  DESC_PREFIX = "Created by #{ENV['JIRA_MAILADDRESS']} Script 'AnyToJira'\n\n"

  attr_accessor :client, :project_id, :issue_type

  def initialize
    @client = JIRA::Client.new(JIRA_COMMON.options)
    @project_id = @client.Project.find(ENV['JIRA_PROJECT_NAME']).id
    @issue_type = @client.Issuetype.all.find do |type|
      type.name == ENV['JIRA_ISSUE_NAME']
    end.id
  end

  def send_jira(summary, description)
    # return if self.validation(summary)
    issue = @client.Issue.build
    response = issue.save(
      fields: {
        summary: summary,
        description: DESC_PREFIX + description
      }.merge(fields)
    )
    puts response unless response
  end

  private

  def fields
    labels.merge(project).merge(issue_type)
  end

  def labels
    {
      labels: [
        ENV['JIRA_LABEL']
      ]
    }
  end

  def project
    {
      project: {
        id: @project_id
      }
    }
  end

  def issue_type
    {
      issuetype: {
        id: @issue_type
      }
    }
  end

  # def validation(summary)
  #   query = "PROJECT = #{ENV['JIRA_PROJECT_NAME']}"
  #   already_exist = @client.Issue.jql(query).any? do |issue|
  #     issue.issuetype.id == @issue_type &&
  #         issue.project.id == @project_id &&
  #         issue.summary == summary
  #   end
  #   puts 'already exist : ' + summary if already_exist
  #   already_exist
  # end
end
