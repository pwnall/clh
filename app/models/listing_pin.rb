class ListingPin < ActiveRecord::Base
  belongs_to :listing
  
  def hide?
    score < 0.0
  end
  
  def rough_score
    score.to_i
  end  
end
