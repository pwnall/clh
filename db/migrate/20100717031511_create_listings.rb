class CreateListings < ActiveRecord::Migration
  def self.up
    create_table :listings do |t|
      t.string :cl_url, :limit => 128, :null => false

      t.integer :price, :null => false
      t.integer :rooms, :null => false
      t.string :title, :limit => 128, :null => false
      t.datetime :posted_at, :null => false
      
      t.string :location, :limit => 128, :null => false
      t.string :city, :limit => 32, :null => false
      t.decimal :lat, :precision => 14, :scale => 10, :null => false
      t.decimal :lng, :precision => 14, :scale => 10, :null => false

      t.string :parser_hash, :limit => 64, :null => false
    end
    add_index :listings, :cl_url, :unique => true, :null => false
  end

  def self.down
    drop_table :listings
  end
end
