#!/usr/bin/env ruby
require "bundler"
Bundler.require(:default)
require 'yaml'
require_relative 'lib/game'

CLEAR = (ERASE_SCOLLBACK = "\e[3J") + (CURSOR_HOME = "\e[H") + (ERASE_DISPLAY = "\e[2J")

puts CLEAR
puts
puts "Welcome to Storytime!"
puts

cli = HighLine.new
cli.choose do |menu|
  menu.index_suffix = ") "
  menu.character = true
  menu.prompt = "Select a story to play: "

  Dir.glob("stories/*/story.yml").each do |story_yml|
    story_directory = File.dirname story_yml
    story_meta = YAML.load_file story_yml
    menu.choice(story_meta['title']) do
      Game.new(story_directory,story_meta).start
    end
  end
end
