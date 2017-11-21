#!/usr/bin/env ruby
#
# 7. Find the 6 character hex string where the SHA256 hash of that string starts with itself.

require 'digest'

HEX_CHARS = ('0'..'9').to_a + ('a'..'f').to_a

def find_hash(s = '')
  HEX_CHARS.each do |c|
    string = s.dup
    string << c
    if string.length == 6
      hash = Digest::SHA256.hexdigest(string)
      if hash.start_with?(string)
        puts "String: #{string}"
        puts "SHA256: #{hash}"
      end
    else
      find_hash(string)
    end
  end
end

puts "=> Searching for a 6 character string where the SHA256 hash starts with itself..."
find_hash


# ----------------------------------------------------------------------------------
# Output:

# => Searching for a 6 character string where the SHA256 hash starts with itself...
# String: 5b0555
# SHA256: 5b055575c6344fa493324573e2cb79b6e42dce8b4dc2ce76fa73e7710dc1001d
