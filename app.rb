# frozen_string_literal: true

# Fetch service
class Fetch
  require 'uri'
  require 'net/http'

  attr_reader :uri

  def initialize(url)
    url = "http://#{url}" unless url.start_with?(/https?:\/\//)
    @uri = URI(url)
  end

  def execute

    raise 'Invalid URL' unless uri.host

    response = Net::HTTP::Get(uri)

    p response
  end
end

ARGV.each do |url|
  Fetch.new(url).execute
end
