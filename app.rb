# frozen_string_literal: true

require_relative './fetcher'

metadata = ARGV[0] == '--metadata'
ARGV.shift if metadata

ARGV.each do |url|
  service = Fetcher.new(url:, metadata:)
  result = service.fetch
  if metadata
    result.each { |k, v| puts "#{k}: #{v}" }
    puts
  end
end
