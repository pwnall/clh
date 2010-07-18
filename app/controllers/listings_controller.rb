class ListingsController < ApplicationController
  # GET /listings
  # GET /listings.xml
  def index    
    @listing_count = Listing.count

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @listings }
    end
  end
  
  # GET /search
  # GET /search.xml
  def search
    location = nil
    if params[:location] && params[:radius]
      geocode = GeocodeFetch.get params[:location]      
      location = Geokit::LatLng.new geocode[:lat], geocode[:lng]
      radius = params[:radius].to_f
    end
    
    rel = Listing.includes(:pin).order('posted_at DESC')
    unless params[:rooms_min].blank?
      rel = rel.where('rooms >= ?', params[:rooms_min].to_i)
    end
    unless params[:rooms_max].blank?
      rel = rel.where('rooms <= ?', params[:rooms_max].to_i)
    end
    @listings = rel.all.select do |listing|
      next false if listing.pin

      room_price = listing.price / listing.rooms.to_f
      if !params[:room_price_max].blank? &&
          room_price > params[:room_price_max].to_f
        next false
      end
      if !params[:room_price_min].blank? &&
         room_price < params[:room_price_min].to_f
        next false
      end
      
      if location
        if radius < listing.distance_to(location, :units => :miles)
          next false
        end
      end
      true         
    end

    respond_to do |format|
      format.html # search.html.erb
      format.xml  { render :xml => @listings }
    end
  end    

  # GET /listings/1
  # GET /listings/1.xml
  def show
    @listing = Listing.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @listing }
    end
  end

  # PUT /listings/1/pin?score=-1
  def pin
    @listing = Listing.find(params[:id])
    if @listing.pin
      @listing.pin.update_attributes! :score => params[:score]
    else
      @listing.pin = ListingPin.create! :listing => @listing, :score => params[:score]
    end
    
    respond_to do |format|
      format.js # pin.js.rjs
    end
  end
    

  # DELETE /listings/1
  # DELETE /listings/1.xml
  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy

    respond_to do |format|
      format.html { redirect_to(listings_url) }
      format.xml  { head :ok }
    end
  end
end
