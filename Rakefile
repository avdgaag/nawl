#!/usr/bin/env rake
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'yard'

task default: :spec

desc 'Run specs'
RSpec::Core::RakeTask.new 

desc 'Generate docs'
YARD::Rake::YardocTask.new
