# frozen_string_literal: true

# Fetcher: perform get requests and store the reponse in html file
class Fetcher
  require 'uri'
  require 'open-uri'
  require_relative './metadata'

  attr_reader :url, :metadata

  def initialize(url: '', metadata: false)
    @url = url
    @metadata = metadata
  end

  def fetch
    File.write(filename, fetch_content)
    if metadata
      metadata_fetcher = Metadata.new(filename)
      return { last_fetch: Time.now.utc, site: host }.merge(metadata_fetcher.summary)
    end
    filename
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
