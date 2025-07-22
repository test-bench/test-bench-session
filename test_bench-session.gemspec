# -*- encoding: utf-8 -*-
Gem::Specification.new do |spec|
  spec.name = 'test_bench-session'
  spec.version = '3.0.2.0'

  spec.summary = "Core test automation state machine for TestBench"
  spec.description = <<~TEXT.each_line(chomp: true).map(&:strip).join(' ')
  TestBench::Session implements the core testing mechanisms of TestBench: tests, contexts, comments, assertions, and test file
  execution. Sessions also maintain the pass/fail status of the test run. A diagnostic substitute session is also included that
  records session telemetry so that test abstractions built using TestBench (called "Fixtures") can observed and tested in
  isolation.
  TEXT

  spec.homepage = 'http://test-bench.software'
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/test-bench-demo/test-bench-session'

  allowed_push_host = ENV.fetch('RUBYGEMS_PUBLIC_AUTHORITY') { 'https://rubygems.org' }
  spec.metadata['allowed_push_host'] = allowed_push_host

  spec.metadata['namespace'] = 'TestBench::Session'

  spec.license = 'MIT'

  spec.authors = ['Brightworks Digital']
  spec.email = 'development@bright.works'

  spec.require_paths = ['lib']

  spec.files = Dir.glob('lib/**/*')

  spec.platform = Gem::Platform::RUBY

  spec.add_runtime_dependency 'test_bench-telemetry'

  spec.add_development_dependency 'test_bench-bootstrap'
end
