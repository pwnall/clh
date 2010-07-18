class Listing < ActiveRecord::Base
  acts_as_mappable
  
  def location=(new_location)
    super
    geocode = GeocodeFetch.get location, city
    self.lat, self.lng = geocode[:lat], geocode[:lng]
  end
  
  def self.for_url(url)
    where(:cl_url => url).first || new(:cl_url => url)
  end
end
