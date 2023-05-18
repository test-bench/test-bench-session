module TestBench
  class Session
    class Output
      class Writer
        module Defaults
          def self.device
            TestBench::Output::Writer::Defaults.device
          end
        end
      end
    end
  end
end
