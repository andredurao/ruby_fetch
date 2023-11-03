# frozen_string_literal: true

require "minitest/autorun"
require 'webmock/minitest'
require_relative './fetcher'

# Fetcher test
class FetcherTest < Minitest::Test
  def setup
    WebMock.enable!

    raw_response_file = File.new('test/google.com.raw')
    stub_request(:get, 'http://google.com').to_return(raw_response_file)
  end

  def test_valid_url_when_is_valid
    fetcher = Fetcher.new('google.com')

    assert(fetcher.valid_url?)
  end

  def test_valid_url_when_is_blank
    fetcher = Fetcher.new('')

    refute(fetcher.valid_url?)
  end

  def test_fetch_invalid_url
    fetcher = Fetcher.new('')

    exception = assert_raises do
      fetcher.fetch
    end

    assert_equal('Invalid URL', exception.message)
  end

  def test_fetch_valid_url
    fetcher = Fetcher.new('google.com')

    body = fetcher.fetch

    refute(body.empty?)
  end
end
