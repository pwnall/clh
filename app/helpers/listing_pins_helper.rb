module ListingPinsHelper
  def enable_listing_pins
    @_enable_listing_pins ||=
        enable_listing_search && ListingPin.where('score > 0').count > 0
  end

  def emphasize_listing_pins
    @_emphasize_scrape_orders ||= enable_listing_pins
  end
  
  def pin_score_description(score)
    {
      -2 => 'Scam', -1 => 'Hidden',
      1 => 'Meh', 2 => 'Like', 3 => 'Love'
    }[score.to_i]
  end  
end
