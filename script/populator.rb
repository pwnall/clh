#!/usr/bin/env ruby
if ARGV.length < 1 || ARGV.length > 2
  puts <<END_USAGE
Usage: #{$0} page_url [page_limit]
  page_url: the address of the main Craigslist page containing the housing
            listings to be imported
  page_limit: number of listing pages to look for (100 postings / page)
              (optional, defaults to 20)
  
Example:
  #{$0} http://boston.craigslist.org/gbs/aap/ 20
END_USAGE
  exit
end

ENV['RAILS_ENV'] ||= 'production'
page_url = ARGV[0]
page_limit = ARGV[1] && ARGV[1].to_i

require File.expand_path('../../config/environment.rb', __FILE__)
ListingPopulator.new.run page_url, page_limit || 20
