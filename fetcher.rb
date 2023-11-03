# frozen_string_literal: true

# Fetcher: perform get requests and store the reponse in html file
class Fetcher
  require 'uri'
  require 'open-uri'
  require_relative './metadata'

  attr_reader :url

  def initialize(url = '')
    @url = url
  end

  def fetch
    File.write(filename, fetch_content)
    metadata = Metadata.new(filename)

    { last_fetch: Time.now.utc, site: host }.merge(metadata.summary)
  end

  def fetch_content
    raise 'Invalid URL' unless valid_url?

    tempfile = URI.open(url)
    tempfile.read
  end

  def valid_url?
    host && !host.empty?
  end

  private

  def host
    URI(url).host
  end

  def filename
    "#{host}.html"
  end
end
