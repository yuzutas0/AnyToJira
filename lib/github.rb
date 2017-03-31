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
class Github
  URL = 'https://github.com/'
  REPOSITORIES = ENV['GITHUB_REPOSITORIES'].split(',')

  class << self
    def issues
      issues = {}
      client = Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
      REPOSITORIES.each do |repo|
        responses(client, repo).each do |issue|
          issues[issue.title] = issue.html_url
        end
      end
      issues
    end

    private

    def responses(client, repository)
      responses, next_response = call_api(client, repository)
      paging(responses, next_response)
      pr_prefix = "#{URL}#{ENV['GITHUB_ORGANIZATION']}/#{repository}/pull/"
      responses.reject do |response|
        response.html_url.start_with? pr_prefix
      end
    end

    def call_api(client, repository)
      responses = []
      repository_path = "#{ENV['GITHUB_ORGANIZATION']}/#{repository}"
      responses.concat client.issues(repository_path)
      next_response = client.last_response.rels[:next]
      [responses, next_response]
    end

    def paging(responses, next_response)
      while next_response
        responses.concat next_response.get.data
        next_response = next_response.get.rels[:next]
      end
    end
  end
end
