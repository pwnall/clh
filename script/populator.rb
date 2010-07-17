#!/usr/bin/env ruby
ENV['RAILS_ENV'] ||= 'development'
page_url = ARGV[0]

require File.expand_path('../../config/environment.rb', __FILE__)
ListingPopulator.new.run page_url
