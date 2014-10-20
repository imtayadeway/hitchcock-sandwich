require 'engtagger'
require 'nokogiri'
require 'open-uri'

def strip_tags(string)
  string.gsub(/<[^>]+>/, '')
end

def stitch_paragraphs(paragraphs)
  paragraphs.join("\n\n")
end

uri = open('https://en.wikipedia.org/wiki/Alfred_Hitchcock')
page = Nokogiri::HTML(uri)
paragraphs = page.css('p').map { |paragraph| paragraph.to_s }

html = stitch_paragraphs(paragraphs)
text = strip_tags(html)

tagger = EngTagger.new
tagged = tagger.add_tags(text)
nouns = tagger.get_nouns(tagged)
puts nouns.keys.sort
