lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "mview_health"

Gem::Specification.new do |spec|
  spec.name        = "mview_health"
  spec.version     = MviewHealth::VERSION
  spec.authors = ["ASR Custom Solutions"]
  spec.email = ["asrwebteam@gmail.com"]
  spec.summary = "Check the health of an Oracle mview"
  spec.homepage    = "https://github.umn.edu/asrweb/mview_health"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the
  # 'allowed_push_host' to allow pushing to a single host or delete this
  # section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://artifactory.umn.edu/artifactory/api/gems/asr-rubygems-local"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # # Specify which files should be added to the gem when it is released.  The
  # # `git ls-files -z` loads the files in the RubyGem that have been added into
  # # git.
  spec.files = Dir.chdir(File.expand_path("..", __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "lastpassify", "~> 0.4.1"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.9"
  spec.add_development_dependency "standard"

  spec.add_runtime_dependency "activerecord", "~> 5.2"
  spec.add_runtime_dependency "activerecord-oracle_enhanced-adapter", "~> 5.2.8"

  spec.add_runtime_dependency "ruby-oci8", "~> 2.2"
end
