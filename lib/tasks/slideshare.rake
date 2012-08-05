require 'digest/sha1'
require 'net/http'
require 'uri'
require 'rexml/document'

desc 'get slides from slideshare.net'
task :slideshare => :environment do
  slideshare_tag('ruby')
  slideshare_tag('rails')
  slideshare_tag('ror')
end

def slideshare_tag(query_string)
  now = Time.now.utc.to_i.to_s
  hashed = Digest::SHA1.hexdigest("#{Slideshare[:shared_secret]}#{now}")
  options = [[:api_key, Slideshare[:api_key]], [:ts, now], [:hash, hashed], [:q, query_string], [:items_per_page, 50], [:sort, 'latest'], [:what, 'tag']]
  query_string = options.collect {|option| option.join('=')}.join('&')

  uri = URI.parse("http://www.slideshare.net/api/2/search_slideshows?#{query_string}")
  http = Net::HTTP.new(uri.host, uri.port)
  response = http.request(Net::HTTP::Get.new(uri.request_uri))

  doc = REXML::Document.new(response.body)
  doc.elements.each('Slideshows/Slideshow') do |slideshow|
    slide = Slide.new
    slide.title = slideshow.elements["Title"].text
    slide.description = slideshow.elements["Description"].text
    slide.username = slideshow.elements["Username"].text
    slide.url = slideshow.elements["URL"].text
    slide.embed = slideshow.elements["Embed"].text
    slide.created_at = slideshow.elements["Created"].text
    slide.updated_at = slide.created_at
    slide.tag_list = slideshow.elements.collect('Tags/Tag') { |tag| tag.text }
    begin
      slide.save
    rescue ActiveRecord::RecordInvalid
    end
  end
end
