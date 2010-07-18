class ScrapeOrder < ActiveRecord::Base
  def run
    starting_time = Time.now
    ListingPopulator.new.run start_url, page_depth    
    self.last_ran_at = Time.now    
    self.last_runtime = last_ran_at - starting_time
  end
end
