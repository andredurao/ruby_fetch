# frozen_string_literal: true

# Fetcher: perform get requests and store the reponse in html file
class Fetcher
  require 'uri'
  require 'net/http'
  require 'logger'

  attr_reader :url, :logger

  def initialize(url = '')
    @url = url.start_with?(/https?:\/\//) ? url : "http://#{url}"
    @logger = Logger.new(STDOUT)
  end

  # https://docs.ruby-lang.org/en/master/Net/HTTP.html#class-Net::HTTP-label-Following+Redirection
  def fetch(limit = 10)
    raise 'Too many HTTP redirects' if limit.zero?
    raise 'Invalid URL' unless valid_url?

    res = Net::HTTP.get_response(URI(@url))
    case res
    when Net::HTTPSuccess
      res
    when Net::HTTPRedirection
      @url = res['Location']
      logger.warn("Redirected to #{@url}")
      fetch(limit - 1)
    else
      res.value
    end
  end

  def save_html_file
    response = fetch
    File.write(filename, response.body)
  end

  def valid_url?
    !!URI(@url).host && !URI(@url).host.empty?
  end

  def filename
    uri = URI(@url)
    "#{uri.host}.html"
  end

  private

  def use_ssl?
    @uri.scheme == 'https'
  end
end
