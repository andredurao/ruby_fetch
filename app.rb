require_relative './fetcher'

ARGV.each do |url|
  service = Fetcher.new(url)
  response = service.save_html_file
end
