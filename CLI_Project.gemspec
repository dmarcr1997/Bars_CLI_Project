require_relative 'lib/CLI_lib/version'

Gem::Specification.new do |spec|
  spec.name          = "BarFinder"
  spec.version       = BarFinder::VERSION
  spec.authors       = ["Damon"]
  spec.email         = ["dmarcr1997@gmail.com"]

  spec.summary       = %q{application to find nearby bars}
  spec.description   = %q{user enters zip code and a list of nearby bars are listed to the user.}
  spec.homepage      = "http://helloworld.com"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "http://helloworld.com"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "http://helloworld.com"
  spec.metadata["changelog_uri"] = "http://helloworld.com"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "pry"
  spec.add_dependency "nokogiri"
  
  
end
