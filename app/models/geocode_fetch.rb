class GeocodeFetch < ActiveRecord::Base
  serialize :response
  
  def self.get(fine_location, coarse_location = '')
    entry = where(:location => fine_location, :city => coarse_location).first
    unless entry
      entry = new :location => fine_location, :city => coarse_location,
          :response => geocode(fine_location, coarse_location)
      entry.save!
    end
    entry.response
  end
  
  def self.geocode(fine_location, coarse_location)
    if coarse_location && coarse_location != ''
      # TODO: cache these guys as well
      coarse_result = 
          Geokit::Geocoders::GoogleGeocoder.geocode(coarse_location)
      bounds = coarse_result && coarse_result.suggested_bounds
    else
      bounds = nil
    end

    result = Geokit::Geocoders::MultiGeocoder.geocode fine_location,
        :bias => bounds
    result.hash
  end    
end
