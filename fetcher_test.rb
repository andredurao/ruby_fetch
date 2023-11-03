# frozen_string_literal: true

require "minitest/autorun"
require 'webmock/minitest'
require_relative './fetcher'

# Fetcher test
class FetcherTest < Minitest::Test
  def setup
    WebMock.enable!

    raw_response_file = File.new('test/google.com.raw')
    stub_request(:get, 'https://google.com').to_return(raw_response_file)
  end

  def test_valid_url_when_is_valid
    fetcher = Fetcher.new('https://google.com')

    assert(fetcher.valid_url?)
  end

  def test_valid_url_when_is_blank
    fetcher = Fetcher.new('')

    refute(fetcher.valid_url?)
  end

  def test_fetch_content_invalid_url
    fetcher = Fetcher.new('')

    exception = assert_raises do
      fetcher.fetch_content
    end

    assert_equal('Invalid URL', exception.message)
  end

  def test_fetch_content_valid_url
    fetcher = Fetcher.new('https://google.com')

    body = fetcher.fetch_content

    refute(body.empty?)
  end

  def test_fetch
    fetcher = Fetcher.new('https://google.com')

    File.stub(:write, true) do
      result = fetcher.fetch

      assert_equal(%i[last_fetch site num_links images], result.keys)
      assert_equal(18, result[:num_links])
      assert_equal(1, result[:images])
      assert_equal('google.com', result[:site])
    end
  end
end
