# frozen_string_literal: true

require 'uri'
require 'net/http'

ARGV.each do |arg|
  uri = URI(arg)

  raise 'Invalid URL' unless uri.host

  p uri, uri.host
end
