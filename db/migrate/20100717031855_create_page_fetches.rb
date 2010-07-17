class CreatePageFetches < ActiveRecord::Migration
  def self.up
    create_table :page_fetches do |t|
      t.string :url, :limit => 128, :null => false
      t.datetime :expires_at, :null => false
      t.binary :contents, :limit => 1.megabyte, :null => false
    end
    add_index :page_fetches, :url, :unique => true, :null => false
  end

  def self.down
    drop_table :page_fetches
  end
end
