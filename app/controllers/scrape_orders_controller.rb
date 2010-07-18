class ScrapeOrdersController < ApplicationController
  # GET /scrape_orders
  # GET /scrape_orders.xml
  def index
    @scrape_orders = ScrapeOrder.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @scrape_orders }
    end
  end

  # POST /scrape_orders/1/run
  # POST /scrape_orders/1/run.xml
  def run
    @scrape_order = ScrapeOrder.find(params[:id])
    @scrape_order.run

    respond_to do |format|
      format.html { redirect_to(scrape_orders_path, :notice => 'Scrape order was successfully ran.') }
      format.xml  { render :xml => @scrape_order }
    end
  end

  # GET /scrape_orders/new
  # GET /scrape_orders/new.xml
  def new
    @scrape_order = ScrapeOrder.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @scrape_order }
    end
  end

  # GET /scrape_orders/1/edit
  def edit
    @scrape_order = ScrapeOrder.find(params[:id])
  end

  # POST /scrape_orders
  # POST /scrape_orders.xml
  def create
    @scrape_order = ScrapeOrder.new(params[:scrape_order])

    respond_to do |format|
      if @scrape_order.save
        format.html { redirect_to(scrape_orders_path, :notice => 'Scrape order was successfully created.') }
        format.xml  { render :xml => @scrape_order, :status => :created, :location => @scrape_order }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @scrape_order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /scrape_orders/1
  # PUT /scrape_orders/1.xml
  def update
    @scrape_order = ScrapeOrder.find(params[:id])

    respond_to do |format|
      if @scrape_order.update_attributes(params[:scrape_order])
        format.html { redirect_to(scrape_orders_path, :notice => 'Scrape order was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @scrape_order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /scrape_orders/1
  # DELETE /scrape_orders/1.xml
  def destroy
    @scrape_order = ScrapeOrder.find(params[:id])
    @scrape_order.destroy

    respond_to do |format|
      format.html { redirect_to(scrape_orders_url) }
      format.xml  { head :ok }
    end
  end
end
