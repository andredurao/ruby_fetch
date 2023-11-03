# frozen_string_literal: true

require_relative './fetcher'

ARGV.each do |url|
  service = Fetcher.new(url)
  summary = service.fetch
  summary.each { |k, v| puts "#{k}: #{v}" }
end
