class PageFetchesController < ApplicationController
  # GET /page_fetches
  # GET /page_fetches.xml
  def index
    @page_fetches = PageFetch.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @page_fetches }
    end
  end

  # GET /page_fetches/1
  # GET /page_fetches/1.xml
  def show
    @page_fetch = PageFetch.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page_fetch }
    end
  end

  # DELETE /page_fetches/1
  # DELETE /page_fetches/1.xml
  def destroy
    @page_fetch = PageFetch.find(params[:id])
    @page_fetch.destroy

    respond_to do |format|
      format.html { redirect_to(page_fetches_url) }
      format.xml  { head :ok }
    end
  end
end
