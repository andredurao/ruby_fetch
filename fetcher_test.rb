# frozen_string_literal: true

require "minitest/autorun"
require 'webmock/minitest'
require_relative './fetcher'

class FetcherTest < Minitest::Test
  def test_when_url_is_valid
    fetcher = Fetcher.new('google.com')

    assert(fetcher.valid_url?)
  end

  def test_when_url_is_blank
    fetcher = Fetcher.new('')

    refute(fetcher.valid_url?)
  end
end
