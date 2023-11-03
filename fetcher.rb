# frozen_string_literal: true

# Fetcher: perform get requests and store the reponse in html file
class Fetcher
  require 'uri'
  require 'open-uri'

  attr_reader :url

  def initialize(url = '')
    @url = url
  end

  def fetch
    raise 'Invalid URL' unless valid_url?

    tempfile = URI.open(url)
    tempfile.read
  end

  def save_html_file
    File.write(filename, fetch)
    filename
  end

  def valid_url?
    uri = URI(url)
    !!uri&.host && !uri.host.empty?
  end

  private

  def filename
    uri = URI(url)
    "#{uri.host}.html"
  end
end
