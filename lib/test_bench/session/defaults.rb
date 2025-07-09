module TestBench
  class Session
    module Defaults
      def self.strict
        disabled_value = 'off'

        env_strict = ENV.fetch('TEST_BENCH_STRICT', disabled_value)

        disabled = env_strict == disabled_value

        !disabled
      end
    end
  end
end
