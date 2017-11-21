#!/usr/bin/env ruby
#
# 7. Concatenate the first names of all U.S. Presidents in alphabetical order --
#    all lowercase, with no commas or spaces. Calculate the SHA256 hash of this string.

require 'json'
require 'digest'

presidents = JSON.parse(File.read('./us_presidents.json'))

presidents_string = presidents.map {|r|
  r['president'].split(' ').first.downcase
}.sort.join

puts "=> Sorted lowercase first names: #{presidents_string}"

hash = Digest::SHA256.hexdigest(presidents_string)

puts "\n=> SHA256: #{hash}"
