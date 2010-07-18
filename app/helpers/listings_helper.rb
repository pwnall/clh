module ListingsHelper
  def enable_listing_search
    @_enable_listing_search ||= enable_scrape_orders && Listing.count != 0    
  end

  def emphasize_listing_search
    @_emphasize_scrape_orders ||=
        enable_listing_search && ListingPin.where('score > 0').count == 0
  end
  
  def google_maps_link(location)
    link_to location, "http://maps.google.com?q=loc:#{URI.encode location}"
  end
end
