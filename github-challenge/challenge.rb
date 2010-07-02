#!/usr/bin/env ruby

require "rubygems"
require "patron"
require "json"

def group_commits_by_author(list)
  grouped_commits = {}
  list["commits"].each do |commit|
    author = commit["author"]["name"]
    grouped_commits[author] ||= []
    grouped_commits[author] << {:author => author, :id => commit["id"], 
      :message => commit["message"], :date => commit["committed_date"]}
  end
  return grouped_commits
end

def create_html(commits_by_author)
  html = ""
  commits_by_author.each do |key, value|
    html << "<h1>#{key}</h1>"
    html << "<ul>"
    value.each do |details|
      html << "<li>Date: #{details[:date]}<br/>Commit: #{details[:id]}<br/>#{details[:message]}</li>"
    end
    html << "</ul>"
  end
  return html
end

session = Patron::Session.new
session.timeout = 10
session.base_url = "http://github.com/api/v2/json"

response = session.get("/commits/list/rails/rails/master")

list = JSON.parse(response.body)
commits = group_commits_by_author(list)
puts create_html(commits)


