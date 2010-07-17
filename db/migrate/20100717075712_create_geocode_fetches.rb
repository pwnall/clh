class CreateGeocodeFetches < ActiveRecord::Migration
  def self.up
    create_table :geocode_fetches do |t|
      t.string :location, :limit => 128, :null => false
      t.string :city, :limit => 32, :null => false
      t.binary :response, :limit => 32.kilobytes, :null => false

      t.timestamps
    end
    add_index :geocode_fetches, [:location, :city], :unique => true,
                                :null => false
  end

  def self.down
    drop_table :geocode_fetches
  end
end
