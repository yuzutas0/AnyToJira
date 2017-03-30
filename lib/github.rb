# encoding:utf-8
# frozen_string_literal: true

# -----------------------------------------------
# Require
# -----------------------------------------------
require 'dotenv'
Dotenv.load '.env'

require 'octokit'

# -----------------------------------------------
# Github -> JIRA
# -----------------------------------------------
class GITHUB
  REPOSITORIES = ENV['GITHUB_REPOSITORIES'].split(',')

  def self.issues
    issues = {}
    client = Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
    REPOSITORIES.each { |repo| responses(client, repo).each { |issue| issues[issue.title] = issue.html_url } }
    issues
  end

  private

  def self.responses(client, repository)
    responses, next_response = call_api(client, repository)
    paging(responses, next_response)
    pull_request_prefix = "https://github.com/#{ENV['GITHUB_ORGANIZATION']}/#{repository}/pull/"
    responses.reject { |response| response.html_url.start_with? pull_request_prefix }
  end

  def self.call_api(client, repository)
    responses = []
    responses.concat client.issues("#{ENV['GITHUB_ORGANIZATION']}/#{repository}")
    next_response = client.last_response.rels[:next]
    [responses, next_response]
  end

  def self.paging(responses, next_response)
    while next_response
      responses.concat next_response.get.data
      next_response = next_response.get.rels[:next]
    end
  end
end
