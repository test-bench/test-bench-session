module TestBench
  class Session
    module Controls
      module Failure
        module Message
          def self.example(suffix=nil)
            suffix = " #{suffix}" if not suffix.nil?

            "Some failure message#{suffix}"
          end
          def self.random = example(Controls::Random.string)
        end
      end
    end
  end
end
