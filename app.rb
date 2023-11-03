require_relative './fetcher'

ARGV.each do |url|
  x = Fetcher.new(url).fetch
  p x
end
