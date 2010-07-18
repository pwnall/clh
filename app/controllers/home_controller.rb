class HomeController < ApplicationController
  def index    
    if ListingPin.where('score > 0').count
      redirect_to listing_pins_path
    elsif Listing.count
      redirect_to listings_path
    else
      redirect_to scrape_orders_path
    end
  end
end
