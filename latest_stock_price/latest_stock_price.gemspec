# frozen_string_literal: true

require_relative "lib/latest_stock_price/version"

Gem::Specification.new do |spec|
  spec.name = "latest_stock_price"
  spec.version = LatestStockPrice::VERSION
  spec.authors = ["Quang Anh"]
  spec.email = ["hoquanganh.bmt@gmail.com"]

  spec.summary = "A local gem for LatestStockPrice library"
  spec.description = "A local gem for LatestStockPrice library"
  spec.homepage = "https://github.com/hoquanganh/latest_stock_price"
  spec.required_ruby_version = ">= 2.6.0"
  spec.license       = 'MIT'

  spec.files = Dir["lib/**/*"]
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'httparty', '~> 0.18.1'
end
