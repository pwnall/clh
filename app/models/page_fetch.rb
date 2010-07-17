class PageFetch < ActiveRecord::Base
  def self.get(url)
    return nil unless page = self.where(:url => url).first
    return page.contents if page.expires_at > Time.now
    page.destroy
    nil
  end
  
  def self.put(url, contents, expires_at)
    page = self.where(:url => url).first
    page ||= self.new :url => url
    page.contents = contents
    page.expires_at = expires_at
    page.save!
    page
  end
end
