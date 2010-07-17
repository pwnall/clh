class ListingsController < ApplicationController
  # GET /listings
  # GET /listings.xml
  def index    
    @listings = Listing.all

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
    
    rel = Listing
    if params[:rooms_min]
      rel = rel.where('rooms >= ?', params[:rooms_min].to_i)
    end
    if params[:rooms_max]
      rel = rel.where('rooms <= ?', params[:rooms_max].to_i)
    end
    @listings = rel.all.select do |listing|
      if params[:room_price_max]
        if (listing.price / listing.rooms.to_f) >  params[:room_price_max].to_f
          next false
        end
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

  # GET /listings/new
  # GET /listings/new.xml
  def new
    @listing = Listing.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @listing }
    end
  end

  # GET /listings/1/edit
  def edit
    @listing = Listing.find(params[:id])
  end

  # POST /listings
  # POST /listings.xml
  def create
    @listing = Listing.new(params[:listing])

    respond_to do |format|
      if @listing.save
        format.html { redirect_to(@listing, :notice => 'Listing was successfully created.') }
        format.xml  { render :xml => @listing, :status => :created, :location => @listing }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @listing.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /listings/1
  # PUT /listings/1.xml
  def update
    @listing = Listing.find(params[:id])

    respond_to do |format|
      if @listing.update_attributes(params[:listing])
        format.html { redirect_to(@listing, :notice => 'Listing was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @listing.errors, :status => :unprocessable_entity }
      end
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
