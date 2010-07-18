class ListingPinsController < ApplicationController
  # GET /listing_pins
  # GET /listing_pins.xml
  def index
    @listing_pins = ListingPin.where('score > 0').order('score DESC').all.
                               group_by(&:rough_score)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @listing_pins }
    end
  end  
end
