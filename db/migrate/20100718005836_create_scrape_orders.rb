class CreateScrapeOrders < ActiveRecord::Migration
  def self.up
    create_table :scrape_orders do |t|
      t.string :start_url, :limit => 128, :null => false
      t.integer :page_depth, :null => false
      t.datetime :ran_last_at, :null => true
      t.float :last_runtime, :null => true
    end
    add_index :scrape_orders, :start_url, :unique => true, :null => false
  end

  def self.down
    drop_table :scrape_orders
  end
end
