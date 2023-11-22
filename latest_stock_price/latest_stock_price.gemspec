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

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'httparty', '~> 0.18.1'
end
