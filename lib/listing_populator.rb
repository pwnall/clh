class ListingPopulator
  def self.parser_hash
    @@parser_hash ||= Digest::MD5.hexdigest File.read(__FILE__)
  end  
  
  def run(url, list_limit = 20)
    list_urls = [url]
    visited = Set.new([url])
    i = 0
    while i < list_limit && i < list_urls.length
      url = list_urls[i]
      list = process_list_page url
      list[:nav].each do |nav_url, nav_anchor|
        next if visited.include? nav_url
        list_urls << nav_url
        visited << nav_url
      end
      list[:posts].each do |post_url, post_anchor|
        process_post_page post_url, post_anchor
      end
      i += 1
    end
  end
  
  def process_post_page(url, anchor_text)    
    listing = Listing.for_url(url)
    return listing if listing.parser_hash == self.class.parser_hash
    process_post_page! url, anchor_text
  end
  
  def process_post_page!(url, anchor_text)
    page = Nokogiri::HTML fetch(url, 14.days)
    page_text = page.root.inner_text

    page_title = nil
    page.root.css('h2').each do |heading|
      text = heading.inner_text
      if text[0, anchor_text.length] == anchor_text
        page_title = text
        break
      end
    end
    return unless page_title
    
    title_suffix = page_title[(anchor_text.length)..-1]
    
    # Price
    return unless match = /^\$(\d+)\s*/.match(page_title)
    price = match[1].to_i
    page_title = page_title[(match[0].length)..-1]
    
    
    # Rooms
    rooms = nil
    if /studio/i =~ page_title
      rooms = 1
    elsif match = /^\/\s*(\d)\s*br/i.match(page_title)
      rooms = match[1].to_i
      page_title = page_title[(match[0].length)..-1]
    elsif match = /(\d)\s+(br)|(bd)/i.match(page_title)
      rooms = match[1].to_i
    else
      [/(\d)\s*bed/i, /bed\w*\W*(\d)/i].each do |pattern|
        if match = pattern.match(page_text)
          rooms = match[1].to_i
        end
      end
    end
    rooms ||= 10  # Unknown number of rooms -- should be easy to spot.
    
    # City.
    city = nil
    page.root.css('div.bchead').css('a').each do |link|
      link_text = link.inner_text.downcase
      if match = /^(.*)\s+craigslist\s*$/.match(link_text)
        city = match[1]
        break
      end
    end
    return unless city
    
    # Location by mapping.
    location = nil
    page.root.css('a').each do |link|
      next unless href = link['href']
      if match = /maps\.google\.com\/.*q\=([^&]+)/.match(href)
        location = URI.decode match[1]
        location = location[4..-1] if location[0, 3] == 'loc'
        break
      end
    end
    # Location by text link.
    unless location
      if match = /\s*\(([^()]+)\)\s*$/.match(title_suffix)
        location = match[1]
        page_title = page_title[0...(-match[0].length)]
      elsif match = /\s*\(([^()]+)\)\s*$/.match(page_title)
        location = match[1].gsub(',', '')
        page_title = page_title[0...(-match[0].length)]
      else
        location = 'Unknown'
      end
    end
    
    # Posting date
    date_regexp = /date:\s*(\d{2,4}\-\d{1,2}\-\d{1,2}.{0,5}\d{1,2}\:\d\d\s*\w{0,2}\s*\w{0,5})/i
    if match = date_regexp.match(page_text)
      posted_at = Time.parse match[1]
    else
      return
    end
    
    listing = Listing.for_url url
    listing.parser_hash = self.class.parser_hash
    listing.price = price
    listing.rooms = rooms
    listing.city = clean_location city
    listing.location = clean_location location
    listing.posted_at = posted_at
    listing.title = clean_title page_title
    listing.save!
  end
  
  def clean_location(raw_location)
    location = raw_location.downcase
    location.gsub! /[^a-z0-9.,&]/, ' '
    location.gsub! /\s+/, ' '
    location.strip!
    location
  end
  
  def clean_title(raw_title)
    title = raw_title.downcase
    title.gsub! /[^a-z0-9.,?\/:&]/, ' '
    title.gsub! '\s+', ' '
    title.gsub! /([^a-z0-9 ])[^a-z0-9 ]+/, '\1'
    title.strip!
    title
  end
  
  def clean_link(rel_url, page_url)
    URI.parse(page_url).merge(rel_url).to_s
  end
  
  def process_list_page(url)
    page = Nokogiri::HTML fetch(url)
    post_links = []
    nav_links = []
    page.root.css('a').each do |link|
      next unless link_target = link['href']
      link_text = link.inner_text      
      case link_target
      when /index\d+.html?$/
        link_target = clean_link link_target, url
        nav_links << [link_target, link_text]
      when /\.craigslist.org\/.*\/\d+\.html?$/
        post_links << [link_target, link_text]
      end
    end
    { :posts => post_links, :nav => nav_links }
  end
  
  def fetch(url, cache_time = 1.minute)
    unless body = PageFetch.get(url)
      body = agent.get_file url
      expires_at = Time.now + cache_time
      PageFetch.put url, body, expires_at
    end
    body
  end
      
  def agent
    @agent ||= Mechanize.new do |a|
      a.user_agent_alias = 'Mac Safari'
    end
  end
  
  def initialize
    @agent = nil
  end   
end
