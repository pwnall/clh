class GeocodeFetchesController < ApplicationController
  # GET /geocode_fetches
  # GET /geocode_fetches.xml
  def index
    @geocode_fetches = GeocodeFetch.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @geocode_fetches }
    end
  end

  # GET /geocode_fetches/1
  # GET /geocode_fetches/1.xml
  def show
    @geocode_fetch = GeocodeFetch.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @geocode_fetch }
    end
  end
end
