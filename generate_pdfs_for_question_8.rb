#!/usr/bin/env ruby

# Pre-generates all of the possible PDFs for question 8.

require 'form_api'
require 'open-uri'

FileUtils.mkdir_p 'generated_pdfs'

TEMPLATE_ID = 'tpl_4z7AQm9ybbZAH2gq'
POSSIBLE_COLORS = %w(Red Blue Yellow Green)

FormAPI.configure do |c|
  c.username  = ENV['API_TOKEN_ID']
  c.password  = ENV['API_TOKEN_SECRET']
end

formapi = FormAPI::Client.new

POSSIBLE_COLORS.each do |top_color|
  POSSIBLE_COLORS.each do |middle_color|
    POSSIBLE_COLORS.each do |bottom_color|
      key = [top_color, middle_color, bottom_color].map { |c| c[0].downcase }.join
      filename = "q8_#{key}_2.pdf"
      path = File.expand_path(File.join('generated_pdfs', filename))

      next if File.exist?(path)

      puts "=> Generating #{[top_color, middle_color, bottom_color].join(', ')}...  (#{filename})"
      response = formapi.generate_pdf(
        template_id: TEMPLATE_ID,
        data: {
          colombian_flag: {
            top_color: top_color,
            middle_color: middle_color,
            bottom_color: bottom_color,
          }
        }
      )

      puts "=====> Downloading..."
      downloaded_pdf = open(response.submission.download_url)
      IO.copy_stream(downloaded_pdf, path)

      if key == 'ybr'
        # Save into this repo
        FileUtils.cp path, 'q8_ybr.pdf'
      end
    end
  end
end

# Then:
#
# cd generated_pdfs
# aws s3 sync --acl public-read . s3://formapi-bitcoin-treasure-hunt
