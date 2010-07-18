class CreateListingPins < ActiveRecord::Migration
  def self.up
    create_table :listing_pins do |t|
      t.integer :listing_id, :null => false
      t.float :score, :null => false
    end
    add_index :listing_pins, :listing_id, :unique => true, :null => false
    add_index :listing_pins, :score, :unique => false, :null => false
  end

  def self.down
    drop_table :listing_pins
  end
end
