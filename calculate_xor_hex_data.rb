#!/usr/bin/env ruby
require 'yaml'
require 'base58'    # Run: gem install base58
require 'digest'

# Bitcoin Address: 1FormAP1qhonAfJToRfYZG9QtNeMFxsurL
PRIVATE_KEY_INTEGER = Base58.decode('5JhMNDAgCKmrLu95VXssARKKafUNGnoyBZbhR4pAn6aFx63LDJY')

answers = YAML.load_file('./answers.yml')
answers_hash = Digest::SHA256.hexdigest(answers.join)

answers_hash_integer = answers_hash.to_i(16)

# XOR the two integers
xor_integer = PRIVATE_KEY_INTEGER ^ answers_hash_integer

xor_hex_data = xor_integer.to_s(16)

puts "XOR Data: #{xor_hex_data}"
