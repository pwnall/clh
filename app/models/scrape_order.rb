class ScrapeOrder < ActiveRecord::Base
  def run
    starting_time = Time.now
    ListingPopulator.new.run start_url, page_depth    
    self.ran_last_at = Time.now    
    self.last_runtime = ran_last_at - starting_time
    save!
  end
end
