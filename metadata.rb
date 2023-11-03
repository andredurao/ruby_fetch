# frozen_string_literal: true

require 'nokogiri'

# Metadata class for fetcher
class Metadata
  attr_reader :doc

  def initialize(filename)
    @doc = Nokogiri::HTML(File.read(filename))
  end

  def summary
    { num_links: links.size, images: images.size }
  end

  def links
    doc.search('a')
  end

  def images
    doc.search('img')
  end
end
