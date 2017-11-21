#!/usr/bin/env ruby
require 'yaml'
require 'base58'    # Run: gem install base58
require 'digest'

XOR_DATA = '8d1ada6e99fd7afa3c3f1f44163aa9ff3fb67350b1f63d582b0109c63e4e78d31ee7e3b6fe'

answers = YAML.load_file('./answers.yml')
answers_hash = Digest::SHA256.hexdigest(answers.join)

# XOR the two integers
xor_integer = answers_hash.to_i(16) ^ XOR_DATA.to_i(16)

# Encode private key as Base-58 string
private_key = Base58.encode(xor_integer)

puts "Private Key: #{private_key}"


# => Private Key: 5JhMNDAgCKmrLu95VXssARKKafUNGnoyBZbhR4pAn6aFx63LDJY

# When you import this private key into some Bitcoin software (such as https://coinb.in/#verify),
# you will see this public address: 1FormAP1qhonAfJToRfYZG9QtNeMFxsurL
