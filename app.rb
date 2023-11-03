# frozen_string_literal: true

# Fetcher class: responsible for requests
class Fetcher
  require 'uri'
  require 'net/http'

  attr_reader :uri

  def initialize(url)
    url = "http://#{url}" unless url.start_with?(/https?:\/\//)
    @uri = URI(url)

    raise 'Invalid URL' unless uri.host
  end

  def fetch
    request = Net::HTTP.get(uri, { 'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:109.0) Gecko/20100101 Firefox/119.0' })
    response = Net::HTTP.start(url.host, url.port, use_ssl: true) { |http| http.request(request) }
    case response
    when Net::HTTPSuccess     then response
    when Net::HTTPRedirection then fetch(response['location'], limit - 1)
    else
      response.error!
    end
    p response
  end
end

ARGV.each do |url|
  Fetcher.new(url).fetch
end
