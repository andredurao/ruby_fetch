# frozen_string_literal: true

require "minitest/autorun"
require_relative './metadata'

# Fetcher test
class MetadataTest < Minitest::Test
  def test_initialize
    metadata = Metadata.new('test/simple.html')

    assert_equal(Nokogiri::HTML4::Document, metadata.doc.class)
  end

  def test_summary
    metadata = Metadata.new('test/simple.html')
    summary = metadata.summary

    assert_equal({ num_links: 4, images: 4 }, summary)
  end
end
