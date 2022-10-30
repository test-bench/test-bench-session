require_relative '../init'

require 'test_bench/isolated'; TestBenchIsolated::TestBench.activate

require 'test_bench/session/controls'

include TestBench

Controls = TestBench::Session::Controls rescue nil
