require 'rubygems'
require 'bundler/setup'
require_relative '../lib/neko'
require 'open-uri'
require 'oga'

aozora_uri= 'http://www.aozora.gr.jp/cards/000148/files/789_14547.html'
html= open(aozora_uri, 'r:Shift_JIS').read.encode('utf-8', universal_newline: true)
lines= Oga.parse_html(html).css('.main_text').text.split("\n")
lines.take(10).each do |ln|
  Neko.new.nekonize(ln)
end
