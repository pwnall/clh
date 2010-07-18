module ScrapeOrdersHelper
  def enable_scrape_orders
    @_enable_scrape_orders ||= true    
  end

  def emphasize_scrape_orders
    @_emphasize_scrape_orders ||= Listing.count == 0
  end
end
