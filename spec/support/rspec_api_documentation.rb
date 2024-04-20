# frozen_string_literal: true

require "rspec_api_documentation"
require "rspec_api_documentation/dsl"

RspecApiDocumentation.configure do |config|
  config.app = Rails.application
  config.format = "json"
  config.docs_dir = Rails.root.join("doc/api")
  config.request_headers_to_include = %w[Accept Content-Type Authorization]
  config.response_headers_to_include = %w[Set-Cookie Content-Type Accept Authorization]
  config.keep_source_order = true
  config.curl_host = "http://#{Rails.application.credentials.host}/"
  config.curl_headers_to_filter = %w[Host Origin Content-Type]
  config.post_body_formatter = proc(&:to_json)
  config.request_body_formatter = :json
end
